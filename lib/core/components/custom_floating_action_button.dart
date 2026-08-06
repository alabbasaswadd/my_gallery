import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({
    super.key,
    required this.onPressed,
    required this.icon,
  });
  final Function() onPressed;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: Icon(icon, color: Theme.of(context).colorScheme.onPrimary),
    );
  }
}
