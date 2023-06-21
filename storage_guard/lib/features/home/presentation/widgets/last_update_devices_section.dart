import 'package:flutter/material.dart';
import 'package:storage_guard/app/constants/text_styles.dart';
class LastUpdateDevicesSection extends StatelessWidget {
  const LastUpdateDevicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Devices",
                  style: TextStyles.regularTextStyle,
                ),
                Spacer(),
                Text(
                  "All Safe",
                  style: TextStyles.regularTextStyle,
                ),
                const SizedBox(width: 4),
                Image.asset(
                  "assets/icons/shield_small.png",
                  width: 25,
                )
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "2 online",
            style: TextStyles.smallLightTextStyle,
          )
        ],
      );
  }
}