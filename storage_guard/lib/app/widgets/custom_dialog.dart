import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog(this.child, {super.key});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      child: child,
    );
  }
}
