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
    return Stack(
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
    );
  }
}
