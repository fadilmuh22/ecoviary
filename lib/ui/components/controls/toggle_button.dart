import 'package:ecoviary/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

class ToggleButton extends StatelessWidget {
  final void Function() onPressed;
  final bool isOn;

  const ToggleButton({
    super.key,
    required this.onPressed,
    required this.isOn,
  });

  @override
  Widget build(BuildContext context) {
    List<BoxShadow> getBoxShadow() {
      return isOn
          ? [
              const BoxShadow(
                color: Color.fromRGBO(145, 26, 26, 0.35),
                offset: Offset(2, 2),
                blurRadius: 8,
                spreadRadius: 1,
              ),
              const BoxShadow(
                color: Color.fromRGBO(145, 26, 26, 0.35),
                offset: Offset(-4, -1),
                blurRadius: 8,
                spreadRadius: -2,
              ),
            ]
          : [
              const BoxShadow(
                color: Color.fromRGBO(96, 96, 96, 0.55),
                offset: Offset(2, 3),
                blurRadius: 8.3,
                spreadRadius: -3,
              ),
              const BoxShadow(
                color: Colors.white,
                offset: Offset(-4, -2),
                blurRadius: 8,
                spreadRadius: -2,
              ),
            ];
    }

    return Container(
      decoration: BoxDecoration(
        boxShadow: getBoxShadow(),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: const Icon(FlutterRemix.shut_down_line),
        padding: const EdgeInsets.all(16),
        constraints: const BoxConstraints(),
        color: isOn ? Colors.white : Theme.of(context).colorScheme.onBackground,
        iconSize: 16,
        style: IconButton.styleFrom(
          backgroundColor: isOn ? MyColor.globalRed0 : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ),
    );
  }
}
