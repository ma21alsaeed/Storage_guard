import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constant/textstyle.dart';

class OperationWidget extends StatelessWidget {
  final String title;
  final String name;
  final double lastTemp;
  final double avgTemp;
  final double lastHum;
  final double avgHum;
  final bool safe;

  const OperationWidget(
      {Key? key,
      required this.title,
      required this.name,
      required this.lastTemp,
      required this.lastHum,
      required this.safe,
      required this.avgTemp,
      required this.avgHum})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.r)),
          color: Colors.grey.shade200,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyles.mediumTextStyle),
            SizedBox(
              height: 5.h,
            ),
            const Divider(
              color: Colors.grey,
            ),
            SizedBox(
              height: 5.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Last Values",
                      style: TextStyles.bodyTextStyle,
                    ),
                    SizedBox(height: 5.h),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${lastTemp} C",
                              style: TextStyles.bodyTextStyle),
                          Image.asset("assets/images/temp_icon.png",
                              fit: BoxFit.contain, height: 30.h),
                          Text("${lastHum} %", style: TextStyles.bodyTextStyle),
                          Image.asset("assets/images/hum_icon.png",
                              fit: BoxFit.contain, height: 30.h),
                        ]),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Average Values",
                      style: TextStyles.bodyTextStyle,
                    ),
                    SizedBox(height: 5.h),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${avgTemp} C", style: TextStyles.bodyTextStyle),
                          Image.asset("assets/images/temp_icon.png",
                              fit: BoxFit.contain, height: 30.h),
                          Text("${avgHum} %", style: TextStyles.bodyTextStyle),
                          Image.asset("assets/images/hum_icon.png",
                              fit: BoxFit.contain, height: 30.h),
                        ]),
                  ],
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    name,
                    style: TextStyles.bodyTextStyle,
                  ),
                  SizedBox(height: 5.h),
                  safe == true
                      ? Image.asset("assets/images/safe_icon.png",
                          fit: BoxFit.contain, height: 30.h)
                      : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset("assets/images/not_safe_icon.png",
                                fit: BoxFit.contain, height: 30.h),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
                              "Not Safe",
                              style:
                                  TextStyle(color: Colors.red, fontSize: 12.sp),
                            )
                          ],
                        ),
                ]),
              ],
            ),
          ],
        ));
  }
}
