import 'package:flutter/material.dart';

class HoursInput extends StatefulWidget {
  const HoursInput({super.key});

  @override
  State<HoursInput> createState() => _HoursInputState();
}

class _HoursInputState extends State<HoursInput> {
  List<TimeOfDay> hours = [];
  int? selectedIndex;

  Future<void> _displayTimePicker(BuildContext context) async {
    final TimeOfDay timeOfDay = TimeOfDay.now();
    var time = await showTimePicker(
      context: context,
      initialTime: timeOfDay,
    );

    if (time != null) {
      setState(() {
        hours.add(time);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 5.0,
          children: List<Widget>.generate(
            hours.length,
            (int index) {
              return InputChip(
                visualDensity: VisualDensity.comfortable,
                label: Text(hours[index].format(context)),
                selected: selectedIndex == index,
                onSelected: (bool selected) {
                  setState(() {
                    if (selectedIndex == index) {
                      selectedIndex = null;
                    } else {
                      selectedIndex = index;
                    }
                  });
                },
                onDeleted: () {
                  setState(() {
                    hours.removeAt(index);
                  });
                },
              );
            },
          ).toList(),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _displayTimePicker(context);
            });
          },
          child: const Text('Add'),
        )
      ],
    );
  }
}
