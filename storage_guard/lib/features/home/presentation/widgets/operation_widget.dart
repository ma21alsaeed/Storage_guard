import 'package:flutter/material.dart';
import 'package:storage_guard/app/constants/colors.dart';
import 'package:storage_guard/app/constants/text_styles.dart';
import 'package:storage_guard/app/di.dart';

import '../../../operation/presentation/operation_page.dart';

class OperationWidget extends StatelessWidget {
  const OperationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        DI.bluetoothService.requestBluetoothPermission();
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const OperationPage()));
      },
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Storage Operation",
                style: TextStyles.bodyTitleTextStyle,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 7),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(
                      color: Colors.black54,
                      height: 12,
                    ),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        const _ValuesColumn("Current", "18", "40"),
                        Container(
                          height: 55,
                          padding: const EdgeInsets.only(bottom: 4),
                          child: const VerticalDivider(
                            color: Colors.black45,
                          ),
                        ),
                        const _ValuesColumn("Avg", "20", "50"),
                        const SizedBox(width: 6),
                        Column(
                          children: [
                            Text(
                              "B1",
                              style: TextStyles.smallLightTextStyle,
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Image.asset(
                              "assets/icons/shield_small.png",
                              width: 25,
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ValuesColumn extends StatelessWidget {
  const _ValuesColumn(this.title, this.temp, this.humidity);
  final String title;
  final String temp;
  final String humidity;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$title Values",
          style: TextStyles.bodyTextStyle,
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "$temp C",
              style: const TextStyle(
                color: AppColors.textColor,
                fontSize: 14,
                fontWeight: FontWeight.w300,
              ),
            ),
            Image.asset(
              "assets/icons/temp.png",
              width: 25,
            ),
            const SizedBox(
                height: 28,
                child: VerticalDivider(
                  color: Colors.black45,
                  width: 8,
                )),
            Text(
              "$humidity %",
              style: const TextStyle(
                color: AppColors.textColor,
                fontSize: 14,
                fontWeight: FontWeight.w300,
              ),
            ),
            Image.asset(
              "assets/icons/wet_small.png",
              width: 25,
            ),
          ],
        )
      ],
    );
  }
}
