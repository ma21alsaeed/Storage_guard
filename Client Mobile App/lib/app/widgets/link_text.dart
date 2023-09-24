import 'package:flutter/material.dart';

class LinkText extends StatelessWidget {
  const LinkText(this.text,
      {super.key, required this.onTap, this.color, this.fontSize = 16});
  final String text;
  final VoidCallback onTap;
  final Color? color;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: fontSize,
          decoration: TextDecoration.underline,
          color: color ?? theme.colorScheme.primary,
        ),
      ),
    );
  }
}
