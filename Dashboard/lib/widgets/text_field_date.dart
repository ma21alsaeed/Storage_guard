import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constant/colors.dart';

class CircularTextFieldDate extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  const CircularTextFieldDate(
      {super.key, required this.hintText, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(20.0.r),
      child: TextField(
        controller: controller,
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
        onTap: () async {
          DateTime? selectedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime(2100),
          );
          controller.text = selectedDate.toString();
        },
      ),
    );
  }
}
