import 'package:flutter/material.dart';
import 'package:storage_guard/app/constants/text_styles.dart';
import 'package:storage_guard/features/operation/data/operation_model.dart';

class LastUpdateDevicesSection extends StatelessWidget {
  const LastUpdateDevicesSection(this.operations, this.isAllSafe, {super.key});
  final List<OperationModel> operations;
  final bool isAllSafe;
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
              const Spacer(),
              Text(
                isAllSafe ? "All Safe" : "Not Safe",
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
          "${operations.length} online",
          style: TextStyles.smallLightTextStyle,
        )
      ],
    );
  }
}
