import "dart:async";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:get/get.dart";
import "package:storage_guard_dashboard/constant/colors.dart";
import "package:storage_guard_dashboard/controllers/home_page_controller.dart";
import "package:storage_guard_dashboard/widgets/menu.dart";
import "package:syncfusion_flutter_charts/charts.dart";
import "../constant/textstyle.dart";
import "../models/pie_data.dart";
import "../models/sensor_data.dart";
import "../widgets/appbar.dart";
import "../widgets/operation_widger.dart";

class HomePage extends StatelessWidget {
  final HomePageController homePageController = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: CustomAppBar(textTitle: "Home"),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(20.r),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /* Material(
          elevation: 2,
          child: Padding(
            padding: EdgeInsets.fromLTRB(30.w, 30.h, 0, 0),
            child: Container(
                padding: EdgeInsets.fromLTRB(60.w, 40.h, 0, 0),
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.height * 0.2,
                decoration: const BoxDecoration(
                    color: AppColors.mainblue,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Text(
                  "Hello , Mahmoud!",
                  style: TextStyle(color: Colors.white, fontSize: 40.sp),
                ),
            ),
          ),
        ),*/

              Container(
                  padding: EdgeInsets.all(20.r),
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Overview",
                          style: TextStyles.titleTextStyle,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        const Divider(
                          color: AppColors.mainblue,
                          thickness: 2,
                        ),
                        Expanded(
                          child: Row(children: [
                            Expanded(
                              child: GetBuilder<HomePageController>(
                                builder: (controller) {
                                  final pageController = PageController();
                          
                                  Timer.periodic(Duration(seconds: 1),
                                      (timer) {
                                    if (pageController.page ==
                                        controller.notfinishedoperationsList.length) {
                                      pageController.animateToPage(
                                        0,
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeInOut,
                                      );
                                    } else {
                                      pageController.nextPage(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeInOut,
                                      );
                                    }
                                  });
                                  return PageView.builder(
                                    controller: pageController,
                                    itemCount: controller
                                        .notfinishedoperationsList.length,
                                    itemBuilder: (context, index) {
                                     
                                      final operation = controller
                                          .notfinishedoperationsList[index];
                                      controller.getAllSensorData(operation.id);
                                      return SfCartesianChart(
                                        title: ChartTitle(
                                          text:
                                              'Sensor Data for Operation ${operation.name}',
                                          textStyle:
                                              const TextStyle(fontSize: 12),
                                        ),
                                        primaryXAxis: DateTimeAxis(),
                                        legend: Legend(isVisible: true),
                                        series: <ChartSeries>[
                                          // Renders line chart
                                          LineSeries<SensorData, DateTime>(
                                            dataLabelSettings:
                                                DataLabelSettings(
                                              isVisible: true,
                                            ),
                                            enableTooltip: true,
                                            dataSource:
                                                controller.sensorReadings,
                                            name: "Temp",
                                            xValueMapper:
                                                (SensorData point, _) =>
                                                    point.readAt,
                                            yValueMapper:
                                                (SensorData point, _) =>
                                                    point.temperature,
                                          ),
                                          LineSeries<SensorData, DateTime>(
                                            dataLabelSettings:
                                                DataLabelSettings(
                                              isVisible: true,
                                            ),
                                            enableTooltip: true,
                                            name: "Humidity",
                                            color: Colors.green,
                                            dataSource:
                                                controller.sensorReadings,
                                            xValueMapper:
                                                (SensorData point, _) =>
                                                    point.readAt,
                                            yValueMapper:
                                                (SensorData point, _) =>
                                                    point.humidity,
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                            Expanded(
                              child: GetBuilder<HomePageController>(
                                  builder: (controller) => Row(
                                        children: [
                                          SfCircularChart(
                                              legend: Legend(isVisible: true),
                                              title: ChartTitle(
                                                  text: 'Product Count'),
                                              series: <CircularSeries>[
                                                // Render pie char
                                                PieSeries<PieData, String>(
                                                    dataLabelSettings:
                                                        DataLabelSettings(
                                                      isVisible: true,
                                                    ),
                                                    enableTooltip: true,
                                                    dataSource: controller
                                                        .productsCountList,
                                                    xValueMapper:
                                                        (PieData data, _) =>
                                                            data.x,
                                                    yValueMapper:
                                                        (PieData data, _) =>
                                                            data.y)
                                              ]),
                                          SfCircularChart(
                                              legend: Legend(isVisible: true),
                                              title: ChartTitle(
                                                  text: 'Reading Count'),
                                              series: <CircularSeries>[
                                                // Render pie char
                                                PieSeries<PieData, String>(
                                                    dataLabelSettings:
                                                        DataLabelSettings(
                                                      isVisible: true,
                                                    ),
                                                    enableTooltip: true,
                                                    dataSource: controller
                                                        .readingsCountList,
                                                    xValueMapper:
                                                        (PieData data, _) =>
                                                            data.x,
                                                    yValueMapper:
                                                        (PieData data, _) =>
                                                            data.y)
                                              ]),
                                        ],
                                      )),
                            ),
                          ]),
                        )
                      ])),
              SizedBox(
                height: 20.h,
              ),
              Row(children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(20.r),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Finished Operations",
                            style: TextStyles.titleTextStyle,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          const Divider(
                            color: AppColors.mainblue,
                            thickness: 2,
                          ),
                          Expanded(
                            child: GetBuilder<HomePageController>(
                                builder: (controller) => controller
                                        .finishedoperationsList.isNotEmpty
                                    ? ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: controller
                                                .finishedoperationsList.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5.h),
                                            child: OperationWidget(
                                                title: controller
                                                    .finishedoperationsList[index].type,
                                                name: controller
                                                    .finishedoperationsList[index].name,
                                                lastHum: controller
                                                        .finishedoperationsList[index]
                                                        .lastHumidity ??
                                                    0.0,
                                                lastTemp: controller
                                                        .finishedoperationsList[index]
                                                        .lastTemp ??
                                                    0.0,
                                                avgHum: controller
                                                        .finishedoperationsList[index]
                                                        .avgHumidity ??
                                                    0.0,
                                                avgTemp: controller
                                                        .finishedoperationsList[index]
                                                        .avgTemp ??
                                                    0,
                                                safe: controller
                                                            .finishedoperationsList[index]
                                                            .safetyStatus ==
                                                        1
                                                    ? true
                                                    : false),
                                          );
                                        },
                                      )
                                    : Text("No data")),
                          )
                        ]),
                  ),
                ),
                SizedBox(
                  width: 30.w,
                ),
                Expanded(
                  child: Container(
                      padding: EdgeInsets.all(20.r),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Last Update",
                              style: TextStyles.titleTextStyle,
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            const Divider(
                              color: AppColors.mainblue,
                              thickness: 2,
                            ),
                            GetBuilder<HomePageController>(
                              builder: (controller) => Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        "Devices",
                                        style: TextStyles.bodyTextStyle,
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Text(
                                          "${controller.numberOfOperation} online"),
                                    ],
                                  ),
                                  SizedBox(width: 100.w),
                                  Row(
                                    children: [
                                      Text(
                                        "All Safe",
                                        style: TextStyles.bodyTextStyle,
                                      ),
                                      SizedBox(
                                        width: 10.h,
                                      ),
                                      controller.allSafe
                                          ? Image.asset(
                                              "assets/images/safe_icon.png",
                                              fit: BoxFit.contain,
                                              height: 30.h)
                                          : SizedBox(),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 20.h),
                            ListView(
                              shrinkWrap: true,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade50,
                                      borderRadius:
                                          BorderRadius.circular(20.r)),
                                  child: Padding(
                                    padding: EdgeInsets.all(20.r),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "add packages to Warehouse B1",
                                          style: TextStyles.bodyTextStyle,
                                        ),
                                        SizedBox(height: 5.h),
                                        const Text(
                                          "30 min",
                                          style: TextStyle(
                                              fontSize: 8, color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade50,
                                      borderRadius:
                                          BorderRadius.circular(20.r)),
                                  child: Padding(
                                    padding: EdgeInsets.all(20.r),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "add packages to Warehouse B1",
                                          style: TextStyles.bodyTextStyle,
                                        ),
                                        SizedBox(height: 5.h),
                                        const Text(
                                          "30 min",
                                          style: TextStyle(
                                              fontSize: 8, color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )
                          ])),
                ),
              ])
            ]),
      )),
    );
  }
}
