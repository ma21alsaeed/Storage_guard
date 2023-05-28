import "package:flutter/material.dart";
import 'package:storage_guard/app/constants/colors.dart';

abstract class TextStyles {
  //Bold
  static TextStyle titleTextStyle = const TextStyle(
    color: AppColors.textColor,
    fontSize: 30,
    fontWeight: FontWeight.w700,
  );
  //Semi Bold
  static TextStyle semiTitleTextStyle = const TextStyle(
    color: AppColors.textColor,
    fontSize: 28,
    fontWeight: FontWeight.w600,
  );
  //Medium
  static TextStyle mediumTextStyle = const TextStyle(
    color: AppColors.textColor,
    fontSize: 20,
    fontWeight: FontWeight.w500,
  );
  //Regular
  static TextStyle regularTextStyle = const TextStyle(
    color: AppColors.textColor,
    fontSize: 20,
  );
  //Light
  static TextStyle lightTextStyle = const TextStyle(
    color: AppColors.textColor,
    fontSize: 19,
    fontWeight: FontWeight.w300,
  );
  static TextStyle smallLightTextStyle = const TextStyle(
    color: AppColors.textColor,
    fontSize: 16,
    fontWeight: FontWeight.w300,
  );
}
