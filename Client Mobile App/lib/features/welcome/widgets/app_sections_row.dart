import 'package:flutter/material.dart';
import 'package:storage_guard/app/constants/text_styles.dart';

class AppSectionsRow extends StatelessWidget {
  const AppSectionsRow(this.assetName, this.title, {super.key});
  final String assetName;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 30,
          height: 30,
          child: Image.asset(assetName),
        ),
        const SizedBox(width: 12),
        Flexible(
          child: Text(
            title,
            style: TextStyles.smallLightTextStyle,
          ),
        )
      ],
    );
  }
}
