import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constant/colors.dart';

class StorageGuardTitle extends StatelessWidget {
  const StorageGuardTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'Storage',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 32.sp,
          color: AppColors.mainblue,
        ),
        children: <TextSpan>[
          TextSpan(
            text: 'Guard',
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 32.sp,
              color: AppColors.mainblue,
            ),
          ),
        ],
      ),
    );
  }
}
