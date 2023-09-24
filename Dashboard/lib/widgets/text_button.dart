import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constant/colors.dart';

class CircularTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;

  const CircularTextButton(
      {Key? key, required this.onPressed, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          gradient: LinearGradient(colors: [
            AppColors.mainblue.withOpacity(0.75),
            AppColors.mainblue
          ])),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent),
        child: Text(
          label,
          style: TextStyle(fontSize: 16.sp),
        ),
      ),
    );
  }
}
