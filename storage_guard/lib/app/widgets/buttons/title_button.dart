import 'package:flutter/material.dart';

class TitleButton extends StatelessWidget {
  const TitleButton(this.title, {super.key});
  final String title;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () => Navigator.pop(context),
        child: Text(
          title,
          style: const TextStyle(color: Color(0xFF1E1E1E), fontSize: 18),
        ));
  }
}
