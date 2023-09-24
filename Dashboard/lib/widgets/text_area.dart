import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constant/colors.dart';

class CircularTextArea extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;

  const CircularTextArea({super.key, required this.hintText,required this.controller});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(20.0.r),
      child: TextField(
        controller: controller,
        maxLines: 4,
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0.r),
            borderSide: BorderSide(color: AppColors.textFieldColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0.r),
            borderSide: BorderSide(color: AppColors.textFieldColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0.r),
            borderSide: BorderSide(color: AppColors.textFieldColor),
          ),
          filled: true,
          fillColor: Colors.grey[200],
          contentPadding:
              EdgeInsets.symmetric(vertical: 16.0.h, horizontal: 16.0),
        ),
      ),
    );
  }
}
