import 'package:ecoviary/ui/components/controls/toggle_button.dart';
import 'package:flutter/material.dart';

class ControlItem extends StatefulWidget {
  final Widget icon;
  final bool value;
  final Future<void> Function(bool) onChange;

  const ControlItem({
    super.key,
    required this.icon,
    required this.value,
    required this.onChange,
  });

  @override
  State<ControlItem> createState() => _ControlItemState();
}

class _ControlItemState extends State<ControlItem> {
  bool isLoading = false;

  void handlePress() async {
    setState(() {
      isLoading = true;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sedang memproses...'),
        ),
      );
    });

    await widget.onChange(!widget.value);

    setState(() {
      isLoading = false;
      Future.delayed(const Duration(milliseconds: 500), () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.icon,
        const SizedBox(height: 36),
        Transform.scale(
          scale: 1.5,
          child: ToggleButton(
            isOn: widget.value,
            onPressed: isLoading ? null : handlePress,
          ),
        ),
      ],
    );
  }
}
