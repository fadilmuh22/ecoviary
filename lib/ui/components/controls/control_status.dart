import 'package:flutter/material.dart';

class ControlStatus extends StatelessWidget {
  final bool isActive;
  final String title;
  final IconData icon;

  const ControlStatus({
    super.key,
    required this.isActive,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
          child: Icon(
            icon,
            size: 24,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(title),
        FilledButton(
          onPressed: isActive ? () {} : null,
          style: Theme.of(context).filledButtonTheme.style!.copyWith(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
          child: Text(isActive ? 'Aktif' : 'Mati'),
        )
      ],
    );
  }
}
