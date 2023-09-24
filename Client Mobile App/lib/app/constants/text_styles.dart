import "package:flutter/material.dart";
import 'package:storage_guard/app/constants/colors.dart';

abstract class TextStyles {
  //Bold
  static TextStyle titleTextStyle = const TextStyle(
      color: AppColors.textColor, fontSize: 30, fontFamily: "Inter");
  //Semi Bold
  static TextStyle semiTitleTextStyle = const TextStyle(
      color: AppColors.textColor,
      fontSize: 28,
      fontWeight: FontWeight.w600,
      fontFamily: "Inter");
  static TextStyle titleDividerTextStyle = const TextStyle(
      color: AppColors.textColor,
      fontSize: 24,
      fontWeight: FontWeight.w600,
      fontFamily: "Inter");
  //Medium
  static TextStyle mediumTextStyle = const TextStyle(
      color: AppColors.textColor,
      fontSize: 20,
      fontWeight: FontWeight.w500,
      fontFamily: "Inter");
  //Regular
  static TextStyle regularTextStyle = const TextStyle(
    color: AppColors.textColor,
    fontFamily: "Inter",
    fontSize: 20,
  );static TextStyle regularNotSafeTextStyle = const TextStyle(
    color: Colors.red,
    fontFamily: "Inter",
    fontSize: 20,
  );
  static TextStyle bodyTitleTextStyle = const TextStyle(
    color: AppColors.textColor,
    fontSize: 16,
    fontFamily: "Inter",
  );
  //Light
  static TextStyle lightTextStyle = const TextStyle(
      color: AppColors.textColor,
      fontSize: 19,
      fontWeight: FontWeight.w300,
      fontFamily: "Inter");
  static TextStyle smallLightTextStyle = const TextStyle(
      color: AppColors.textColor,
      fontSize: 16,
      fontWeight: FontWeight.w300,
      fontFamily: "Inter");
  static TextStyle bodyTextStyle = const TextStyle(
      color: AppColors.textColor,
      fontSize: 15,
      fontWeight: FontWeight.w300,
      fontFamily: "Inter");
}
