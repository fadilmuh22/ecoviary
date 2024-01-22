import 'package:ecoviary/utils/utils.dart';
import 'package:flutter/material.dart';

class DaysDropdown extends StatefulWidget {
  final DaysEnum value;
  final void Function(DaysEnum?) onChange;

  const DaysDropdown({
    super.key,
    required this.value,
    required this.onChange,
  });

  @override
  State<DaysDropdown> createState() => _DaysDropdownState();
}

class _DaysDropdownState extends State<DaysDropdown> {
  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
        constraints: BoxConstraints(),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<DaysEnum>(
          isDense: true,
          isExpanded: true,
          value: widget.value,
          onChanged: widget.onChange,
          items: DaysEnum.values.map<DropdownMenuItem<DaysEnum>>(
            (DaysEnum value) {
              return DropdownMenuItem<DaysEnum>(
                value: value,
                child: Text(daysEnumMapper(value)),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
