import 'package:ecoviary/components/hours_input.dart';
import 'package:ecoviary/models/automations_model.dart';
import 'package:ecoviary/services/realtime_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weekday_selector/weekday_selector.dart';

class AutomationForm extends StatefulWidget {
  const AutomationForm({super.key});

  @override
  State<AutomationForm> createState() => _AutomationFormState();
}

class _AutomationFormState extends State<AutomationForm> {
  final _formKey = GlobalKey<FormState>();

  final _dateController = TextEditingController();

  final List<TimeOfDay> _foodTimeList = [];
  final List<TimeOfDay> _waterTimeList = [];
  final _weekdayValues = List.filled(7, false);
  DateTime? _selectedDate;

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

  Future<void> _handleSubmit(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      var data = Automations(
        food: _foodTimeList.map((e) => e.format(context)).toList(),
        water: _waterTimeList.map((e) => e.format(context)).toList(),
        disinfectant: _weekdayValues,
        date: _selectedDate!.millisecondsSinceEpoch,
        status: AutomationsStatus.initial,
      );

      Collections.automations.ref.push().set(data.toJson());
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      children: [
        Form(
          // key: _formKey,
          child: Column(
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
              const SizedBox(height: 8),
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
              const SizedBox(height: 8),
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
              const SizedBox(height: 8),
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
              FilledButton(
                onPressed: () {
                  _handleSubmit(context);
                },
                child: const Text('Simpan'),
              )
            ],
          ),
        ),
      ],
    );
  }
}
