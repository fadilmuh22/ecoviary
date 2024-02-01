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
              'assets/images/sprinkler_on.png',
            ),
          ),
          Image.asset(
            'assets/images/sprinkler_off.png',
          ),
        ],
      ),
    );
  }
}
