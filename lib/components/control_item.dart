import 'package:flutter/material.dart';

class ControlItem extends StatelessWidget {
  final Widget icon;
  final bool value;
  final Function(bool) onChange;

  const ControlItem({
    super.key,
    required this.icon,
    required this.value,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        icon,
        const SizedBox(height: 36),
        Transform.scale(
          scale: 1.5,
          child: Switch(
            value: value,
            onChanged: onChange,
            materialTapTargetSize: MaterialTapTargetSize.padded,
          ),
        ),
      ],
    );
  }
}
