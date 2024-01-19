import 'package:flutter/material.dart';

class HoursInput extends StatefulWidget {
  final List<TimeOfDay> hours;
  final Function(List<TimeOfDay>) onChange;

  const HoursInput({
    super.key,
    required this.hours,
    required this.onChange,
  });

  @override
  State<HoursInput> createState() => _HoursInputState();
}

class _HoursInputState extends State<HoursInput> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> _displayTimePicker(BuildContext context) async {
    final TimeOfDay timeOfDay = TimeOfDay.now();
    var time = await showTimePicker(
      context: context,
      initialTime: timeOfDay,
    );

    if (time != null) {
      setState(() {
        widget.onChange([...widget.hours, time]);
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
              widget.hours.length,
              (int index) {
                return InputChip(
                  visualDensity: VisualDensity.comfortable,
                  label: Text(widget.hours[index].format(context)),
                  onDeleted: () {
                    setState(() {
                      widget.hours.removeAt(index);
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
                child: const Text('Tambah'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
