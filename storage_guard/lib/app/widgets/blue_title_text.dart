import 'package:flutter/material.dart';
import 'package:storage_guard/app/constants/colors.dart';

class BlueTitleText extends StatelessWidget {
  const BlueTitleText(this.title, {super.key});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
          color: AppColors.mainblue,
          fontSize: 28,
          fontWeight: FontWeight.w500,
          fontFamily: "Inter"),
    );
  }
}
