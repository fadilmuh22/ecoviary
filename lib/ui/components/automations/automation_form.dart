import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:ecoviary/data/models/automations_model.dart';
import 'package:ecoviary/data/services/realtime_database.dart';
import 'package:ecoviary/ui/components/hours_input.dart';
import 'package:weekday_selector/weekday_selector.dart';

class AutomationForm extends StatefulWidget {
  final Automations? automation;

  const AutomationForm({
    super.key,
    this.automation,
  });

  @override
  State<AutomationForm> createState() => _AutomationFormState();
}

class _AutomationFormState extends State<AutomationForm> {
  final _dateController = TextEditingController();

  final List<TimeOfDay> _foodTimeList = [];
  final List<TimeOfDay> _waterTimeList = [];
  final _weekdayValues = List.filled(7, false);
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _fillFields();
  }

  void _fillFields() {
    if (widget.automation == null) return;

    _foodTimeList.addAll(widget.automation!.food
        .map((e) => TimeOfDay.fromDateTime(
            DateFormat('dd MMMM yyyy, hh:mm').parse(e.toString())))
        .toList());
    _waterTimeList.addAll(widget.automation!.water
        .map((e) => TimeOfDay.fromDateTime(
            DateFormat('dd MMMM yyyy, hh:mm').parse(e.toString())))
        .toList());
    _weekdayValues.addAll(widget.automation!.disinfectant);
    _selectedDate =
        DateTime.fromMillisecondsSinceEpoch(widget.automation!.date);
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
      id: widget.automation?.id ?? '',
      food: _foodTimeList.map((e) => e.format(context)).toList(),
      water: _waterTimeList.map((e) => e.format(context)).toList(),
      disinfectant: _weekdayValues,
      date: _selectedDate!.millisecondsSinceEpoch,
      status: AutomationsStatus.initial,
    );

    Collections.automations.ref.push().set(data.toJson()).then((value) {
      _clearFields();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Automation added'),
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
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      children: [
        Wrap(
          spacing: 4,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        const Text(
                          'Pemberian pakan dalam sehari',
                        ),
                        const SizedBox(height: 8),
                        HoursInput(
                          hours: _foodTimeList,
                          onChange: (list) {
                            setState(() {
                              _foodTimeList.addAll(list);
                            });
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        const Text('Pemberian minum dalam sehari'),
                        const SizedBox(height: 8),
                        HoursInput(
                          hours: _waterTimeList,
                          onChange: (list) {
                            setState(() {
                              _waterTimeList.addAll(list);
                            });
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 12,
                ),
                child: Column(
                  children: [
                    const Text('Pemberian disinfektan dalam seminggu'),
                    const SizedBox(height: 8),
                    WeekdaySelector(
                      onChanged: (int day) {
                        setState(() {
                          final index = day % 7;
                          _weekdayValues[index] = !_weekdayValues[index];
                        });
                      },
                      values: _weekdayValues,
                    )
                  ],
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 12,
                ),
                child: Column(
                  children: [
                    const Text('Waktu mulai automasi'),
                    TextFormField(
                      controller: _dateController,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        hintText: 'Tekan untuk mengubah',
                        border: InputBorder.none,
                      ),
                      readOnly: true,
                      onTap: () {
                        _displayDatePicker(context);
                      },
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FilledButton(
                  onPressed: () {
                    _handleSubmit(context);
                  },
                  child: const Text('Simpan'),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
