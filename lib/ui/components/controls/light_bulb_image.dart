import 'package:flutter/material.dart';

class LightBulbImage extends StatefulWidget {
  final bool isOn;
  const LightBulbImage({super.key, required this.isOn});

  @override
  State<LightBulbImage> createState() => _LightBulbImageState();
}

class _LightBulbImageState extends State<LightBulbImage> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 150),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      child: Stack(
        key: ValueKey<bool>(widget.isOn),
        children: [
          Visibility(
            visible: widget.isOn,
            child: Image.asset(
              'assets/images/light_bulb_on.png',
            ),
          ),
          Image.asset(
            'assets/images/light_bulb_off.png',
          ),
        ],
      ),
    );
  }
}
