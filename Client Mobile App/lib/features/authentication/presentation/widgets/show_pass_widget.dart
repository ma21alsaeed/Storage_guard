import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:storage_guard/app/constants/colors.dart';
class ShowPassWidget extends StatelessWidget {
  const ShowPassWidget(
      {super.key, required this.showHide, required this.isHidden});
  final void Function() showHide;
  final bool isHidden;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: showHide,
        child: Icon(
          isHidden ? CupertinoIcons.eye_slash_fill : CupertinoIcons.eye_solid,
          color: AppColors.background,
        ));
  }
}