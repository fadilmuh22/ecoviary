import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  final void Function() onPressed;
  final Icon icon;

  const AddButton({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: icon,
      padding: const EdgeInsets.all(6),
      constraints: const BoxConstraints(),
      color: Colors.white,
      iconSize: 16,
      style: IconButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.inverseSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2),
        ),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }
}
