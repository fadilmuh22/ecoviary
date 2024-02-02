import 'package:flutter/material.dart';

class DisinfectantImage extends StatefulWidget {
  final bool isOn;
  const DisinfectantImage({super.key, required this.isOn});

  @override
  State<DisinfectantImage> createState() => _DisinfectantImageState();
}

class _DisinfectantImageState extends State<DisinfectantImage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Visibility(
          visible: widget.isOn,
          child: Image.asset(
            'assets/images/sprinkler_on.png',
          ),
        ),
        Image.asset(
          'assets/images/sprinkler_off.png',
        ),
      ],
    );
  }
}
