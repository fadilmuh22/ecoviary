import 'package:ecoviary/components/hours_input.dart';
import 'package:ecoviary/models/automations_model.dart';
import 'package:ecoviary/services/realtime_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weekday_selector/weekday_selector.dart';

class AutomationPage extends StatefulWidget {
  const AutomationPage({super.key});

  @override
  State<AutomationPage> createState() => _AutomationPageState();
}

class _AutomationPageState extends State<AutomationPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  final values = List.filled(7, true);

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  late TabController _tabController;

  Future<void> _displayTimePicker(BuildContext context) async {
    final TimeOfDay timeOfDay = TimeOfDay.now();
    var time = await showTimePicker(context: context, initialTime: timeOfDay);

    if (time != null) {
      setState(() {
        _selectedTime = time;
      });
    }
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
      });
    }
  }

  Future<void> _handleSubmit(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      var data = Automations(
        food: [int.parse(_selectedTime.toString())],
        water: [int.parse(_selectedTime.toString())],
        disinfectant: values,
        date: _selectedDate!.millisecondsSinceEpoch,
        status: AutomationsStatus.initial,
      );

      Collections.automations.ref.push().set(data.toJson());
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              text: 'List',
            ),
            Tab(
              text: 'Create',
            ),
          ],
          labelColor: Colors.black,
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              const AutomationList(),
              automationsForm(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget automationsForm(BuildContext context) {
    return Form(
      // key: _formKey,
      child: Column(
        children: [
          Column(
            children: [
              Card(
                child: Column(
                  children: [
                    Text(
                        'Pemberian pakan dalam sehari ${_selectedTime != null ? _selectedTime!.format(context) : ''}'),
                    const HoursInput()
                  ],
                ),
              ),
              Card(
                child: Column(
                  children: [
                    const Text('Pemberian minum dalam sehari'),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Tekan untuk mengubah',
                        border: InputBorder.none,
                      ),
                      readOnly: true,
                      onTap: () {
                        _displayTimePicker(context);
                      },
                    )
                  ],
                ),
              ),
              Card(
                child: Column(
                  children: [
                    const Text('Pemberian disinfektan dalam seminggu'),
                    WeekdaySelector(
                      onChanged: (int day) {
                        setState(() {
                          final index = day % 7;
                          values[index] = !values[index];
                        });
                      },
                      values: values,
                    )
                  ],
                ),
              ),
              Card(
                child: Column(
                  children: [
                    const Text('Waktu mulai automasi'),
                    TextFormField(
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
              FilledButton(
                onPressed: () {
                  _handleSubmit(context);
                },
                child: const Text('Simpan'),
              )
            ],
          )
        ],
      ),
    );
  }
}

class AutomationList extends StatelessWidget {
  const AutomationList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Collections.automations.ref.onValue,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var automations = Map<String, dynamic>.from(
              snapshot.data!.snapshot.value as Map<dynamic, dynamic>);

          return ListView.builder(
            itemCount: automations.length,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            itemBuilder: (context, index) {
              Automations? automation = Automations.fromJson(
                Map<String, dynamic>.from(
                  automations.values.elementAt(index) as Map,
                ),
              );

              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            DateFormat('dd MMMM yyyy, hh:mm').format(
                              DateTime.fromMillisecondsSinceEpoch(
                                1705235703679,
                              ),
                            ),
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          PopupMenuButton(
                            itemBuilder: (context) => [
                              const PopupMenuItem(child: Text('Edit')),
                              const PopupMenuItem(child: Text('Delete')),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: List.generate(
                          automation.food.length,
                          (index) => Chip(
                            visualDensity: VisualDensity.compact,
                            backgroundColor: const Color(0xFFE1E4F3),
                            labelPadding: const EdgeInsets.all(2),
                            shape: const CircleBorder(),
                            label: Text(
                              automation.food[index].toString(),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: List.generate(
                          automation.water.length,
                          (index) => Chip(
                            visualDensity: VisualDensity.compact,
                            backgroundColor: const Color(0xFFE1E4F3),
                            labelPadding: const EdgeInsets.all(2),
                            shape: const CircleBorder(),
                            label: Text(
                              automation.water[index].toString(),
                            ),
                          ),
                        ),
                      ),
                      WeekdaySelector(
                        onChanged: (value) {},
                        values: automation.disinfectant,
                      )
                    ],
                  ),
                ),
              );
            },
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
