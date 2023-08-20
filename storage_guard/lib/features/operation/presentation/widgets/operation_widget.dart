import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:storage_guard/app/constants/colors.dart';
import 'package:storage_guard/app/constants/text_styles.dart';
import 'package:storage_guard/features/operation/data/operation_model.dart';
import 'package:storage_guard/features/operation/presentation/operation_page.dart';

class OperationWidget extends StatelessWidget {
  const OperationWidget(this.operation, {super.key});
  final OperationModel operation;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        PersistentNavBarNavigator.pushNewScreen(context,
            screen: OperationPage(operation.id, {
              "last_temp": operation.lastTemp,
              "last_humidity": operation.lastHumidity,
              "avg_temp": operation.avgTemp,
              "avg_humidity": operation.avgHumidity,
              "safety_status": operation.safetyStatus,
            }),
            withNavBar: false);
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
              const Divider(
                color: Colors.black54,
                height: 12,
              ),
              operation.checkForValues()
                  ? Padding(
                      padding: const EdgeInsets.only(left: 7),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              _ValuesColumn(
                                  "Current",
                                  operation.lastTemp.toString(),
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
                                      : Image.asset(
                                          "assets/icons/not_safe_small.png",
                                          width: 25,
                                        )
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  : Text(
                      "No Temp/Humidity Values Found",
                      style: TextStyles.bodyTextStyle,
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
              "${int.parse(temp.split(".").first)} C",
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
              "${int.parse(humidity.split(".").first)} %",
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
