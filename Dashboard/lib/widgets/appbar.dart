import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constant/colors.dart';
import 'control_buttons.dart';

class CustomAppBar extends AppBar {
  final String textTitle;

  CustomAppBar({Key? key, required this.textTitle})
      : super(
            key: key,
            elevation: 0,
            backgroundColor: AppColors.white,

            iconTheme: const IconThemeData(color: AppColors.mainblue),
            title: Text(
              textTitle,
              style: TextStyle(fontSize: 16.sp, color: AppColors.mainblue),
            ));
}
