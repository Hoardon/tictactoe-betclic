import 'package:flutter/material.dart';

class CtaButton extends StatelessWidget {
  const CtaButton({
    required this.onPressed,
    required this.icon,
    required this.label,
    super.key,
  });

  final void Function()? onPressed;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 28),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        textStyle: Theme.of(context).textTheme.titleMedium,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}