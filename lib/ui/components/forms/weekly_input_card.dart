import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:weekday_selector/weekday_selector.dart';

class WeeklyInputCard extends StatefulWidget {
  final List<bool> weekdayValues;
  final void Function(List<bool>) onChange;

  const WeeklyInputCard({
    super.key,
    required this.weekdayValues,
    required this.onChange,
  });

  @override
  State<WeeklyInputCard> createState() => _WeeklyInputCardState();
}

class _WeeklyInputCardState extends State<WeeklyInputCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Pemberian disinfektan dalam seminggu',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        WeekdaySelector(
          shortWeekdays: dateTimeSymbolMap()['id'].SHORTWEEKDAYS,
          onChanged: (int day) {
            final index = day % 7;
            widget.onChange([...widget.weekdayValues]..[index] =
                !widget.weekdayValues[index]);
          },
          values: widget.weekdayValues,
          textStyle: TextStyle(
            fontSize: 10,
            color: Theme.of(context).colorScheme.onBackground,
            fontWeight: FontWeight.bold,
          ),
          selectedTextStyle: TextStyle(
            fontSize: 10,
            color: Theme.of(context).colorScheme.background,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
