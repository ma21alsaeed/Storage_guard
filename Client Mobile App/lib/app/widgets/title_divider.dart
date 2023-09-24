import 'package:flutter/material.dart';
import 'package:storage_guard/app/constants/colors.dart';
import 'package:storage_guard/app/constants/text_styles.dart';

class TitleDivider extends StatelessWidget {
  const TitleDivider(this.title, {super.key});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyles.titleDividerTextStyle,
        ),
        const SizedBox(height: 8),
        const SizedBox(
          width: 240,
          child: Divider(
            color: AppColors.mainblue,
            thickness: 4,
          ),
        ),
      ],
    );
  }
}
