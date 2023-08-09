import 'package:flutter/material.dart';

class TitleButton extends StatelessWidget {
  const TitleButton(this.title, {super.key, this.color});
  final String title;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () => Navigator.pop(context),
        child: Text(
          title,
          style:
              TextStyle(color: color ?? const Color(0xFF1E1E1E), fontSize: 18),
        ));
  }
}
