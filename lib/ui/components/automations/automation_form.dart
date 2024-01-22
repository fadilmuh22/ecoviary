import 'package:ecoviary/ui/components/forms/weekly_input_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'package:ecoviary/data/models/automations_model.dart';
import 'package:ecoviary/data/services/realtime_database.dart';
import 'package:weekday_selector/weekday_selector.dart';
import 'package:ecoviary/ui/components/forms/hours_input_card.dart';
import 'package:ecoviary/data/providers/form_providers.dart';

class AutomationForm extends ConsumerStatefulWidget {
  final Automations? automation;

  const AutomationForm({
    super.key,
    this.automation,
  });

  @override
  ConsumerState<AutomationForm> createState() => _AutomationFormState();
}

class _AutomationFormState extends ConsumerState<AutomationForm> {
  Automations? _automation;
  final _dateController = TextEditingController();

  List<TimeOfDay> _foodTimeList = [];
  List<TimeOfDay> _waterTimeList = [];
  List<bool> _weekdayValues = List.filled(7, false);
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _automation =
        widget.automation ?? ref.read(automationFormProvider).automation;
    _fillFields();
  }

  void _fillFields() {
    if (_automation == null) {
      return;
    }

    _foodTimeList.addAll(_automation!.food
        .map((e) =>
            TimeOfDay.fromDateTime(DateFormat('hh:mm').parse(e.toString())))
        .toList());
    _waterTimeList.addAll(_automation!.water
        .map((e) =>
            TimeOfDay.fromDateTime(DateFormat('hh:mm').parse(e.toString())))
        .toList());
    _weekdayValues = _automation!.disinfectant;
    _selectedDate = DateTime.fromMillisecondsSinceEpoch(_automation!.date);
    _dateController.text = DateFormat('dd MMMM yyyy').format(_selectedDate!);
  }

  void _clearFields() {
    setState(() {
      _foodTimeList.clear();
      _waterTimeList.clear();
      _weekdayValues.fillRange(0, 7, false);
      _selectedDate = null;
      _dateController.clear();
    });
  }

  Future<void> _displayDatePicker(BuildContext context) async {
    final DateTime initialDate = DateTime.now();
    final firstDayOfWeek =
        initialDate.subtract(Duration(days: initialDate.weekday - 1));
    final lastDayOfWeek = initialDate
        .add(Duration(days: DateTime.daysPerWeek - initialDate.weekday));

    var date = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDayOfWeek,
      lastDate: lastDayOfWeek,
    );

    if (date != null) {
      setState(() {
        _selectedDate = date;
        _dateController.text = DateFormat('dd MMMM yyyy').format(date);
      });
    }
  }

  void _handleSubmit(BuildContext context) {
    if (_foodTimeList.isEmpty ||
        _waterTimeList.isEmpty ||
        _weekdayValues.isEmpty ||
        _selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Harap isi semua data'),
        ),
      );
      return;
    }

    var data = Automations(
      id: _automation?.id ?? '',
      food: _foodTimeList.map((e) => e.format(context)).toList(),
      water: _waterTimeList.map((e) => e.format(context)).toList(),
      disinfectant: _weekdayValues,
      date: _selectedDate!.millisecondsSinceEpoch,
      status: AutomationsStatus.initial,
      activated: true,
    );

    Future<void>? automationFuture;

    if (_automation != null) {
      automationFuture =
          Collections.automations.ref.child(data.id).update(data.toJson());
    } else {
      automationFuture = Collections.automations.ref.push().set(data.toJson());
    }

    automationFuture.then((value) {
      // _clearFields();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Automation ${_automation != null ? 'updated' : 'added'}'),
        ),
      );
    }).catchError(
      (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.toString()),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 16,
      children: [
        HoursInput(
          title: 'Pemberian pakan dalam sehari',
          hours: _foodTimeList,
          onChange: (list) {
            setState(() {
              _foodTimeList = list;
            });
          },
        ),
        HoursInput(
          title: 'Pemberian minum dalam sehari',
          hours: _waterTimeList,
          onChange: (list) {
            setState(() {
              _waterTimeList = list;
            });
          },
        ),
        WeeklyInputCard(
          weekdayValues: _weekdayValues,
          onChange: (list) {
            setState(() {
              _weekdayValues = list;
            });
          },
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Waktu mulai automasi',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _dateController,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: () {
                    _displayDatePicker(context);
                  },
                  icon: const Icon(Icons.calendar_today_rounded),
                  color: Colors.black,
                  iconSize: 14,
                  padding: const EdgeInsets.all(10),
                  constraints: const BoxConstraints(),
                  style: IconButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).colorScheme.secondaryContainer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              ],
            ),
          ],
        ),
        FilledButton(
          style: FilledButton.styleFrom(
            minimumSize: const Size.fromHeight(40),
          ),
          onPressed: () {
            _handleSubmit(context);
          },
          child: const Text('Simpan'),
        )
      ],
    );
  }
}
