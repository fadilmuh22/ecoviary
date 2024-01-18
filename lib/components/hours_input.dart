import 'package:flutter/material.dart';

class HoursInput extends StatefulWidget {
  final Function(List<TimeOfDay>) onChange;

  const HoursInput({
    super.key,
    required this.onChange,
  });

  @override
  State<HoursInput> createState() => _HoursInputState();
}

class _HoursInputState extends State<HoursInput> {
  List<TimeOfDay> hours = [];

  Future<void> _displayTimePicker(BuildContext context) async {
    final TimeOfDay timeOfDay = TimeOfDay.now();
    var time = await showTimePicker(
      context: context,
      initialTime: timeOfDay,
    );

    if (time != null) {
      setState(() {
        hours.add(time);
        widget.onChange(hours);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
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
                  onDeleted: () {
                    setState(() {
                      hours.removeAt(index);
                    });
                  },
                );
              },
            ).toList(),
          ),
          const SizedBox(width: 10),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _displayTimePicker(context);
                  });
                },
                child: const Text('Add'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
