import 'package:flutter/material.dart';
import 'package:storage_guard/app/constants/colors.dart';
import 'package:storage_guard/app/constants/text_styles.dart';
import 'package:storage_guard/app/di.dart';
import 'package:storage_guard/features/operation/data/operation_model.dart';

import '../../../../bluetooth_devices_page.dart';

class OperationWidget extends StatelessWidget {
  const OperationWidget(this.operation, {super.key});
  final OperationModel operation;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        DI.bluetoothService.requestBluetoothPermission();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const BluetoothDevicesPage()));
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
                "${operation.type[0].toUpperCase()}${operation.type.substring(1)} Operation",
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
                        _ValuesColumn("Current", operation.lastTemp.toString(),
                            operation.lastHumidity.toString()),
                        Container(
                          height: 55,
                          padding: const EdgeInsets.only(bottom: 4),
                          child: const VerticalDivider(
                            color: Colors.black45,
                          ),
                        ),
                        _ValuesColumn("Avg", operation.avgTemp.toString(),
                            operation.avgHumidity.toString()),
                        const SizedBox(width: 6),
                        Column(
                          children: [
                            Text(
                              operation.name,
                              style: TextStyles.smallLightTextStyle,
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            operation.safetyStatus == 1
                                ? Image.asset(
                                    "assets/icons/shield_small.png",
                                    width: 25,
                                  )
                                : const Icon(
                                    Icons.safety_check_outlined,
                                    color: AppColors.mainblue,
                                    size: 25,
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
