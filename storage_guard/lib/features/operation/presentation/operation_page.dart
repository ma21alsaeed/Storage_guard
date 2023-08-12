import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/cli_commands.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:storage_guard/app/di.dart';
import 'package:storage_guard/app/widgets/buttons/gradient_button.dart';
import 'package:storage_guard/app/widgets/error_occurred_widget.dart';
import 'package:storage_guard/app/widgets/loading_widget.dart';
import 'package:storage_guard/app/widgets/title_appbar.dart';
import 'package:storage_guard/app/widgets/title_divider.dart';
import 'package:storage_guard/core/funcs.dart';
import 'package:storage_guard/features/operation/data/operation_model.dart';
import 'package:storage_guard/features/operation/data/operation_repositories.dart';
import 'package:storage_guard/features/operation/data/sensor_reading_model.dart';
import 'package:storage_guard/features/operation/presentation/cubit/get_all_operations_cubit.dart'as getAll;
import 'package:storage_guard/features/operation/presentation/cubit/get_operation_cubit.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class OperationPage extends StatefulWidget {
  const OperationPage(this.operationId, this.data, {super.key});
  final int operationId;
  final Map<String, dynamic> data;
  //data format is {
  //   "last_temp": operation.lastTemp,
  //   "last_humidity": operation.lastHumidity,
  //   "avg_temp": operation.avgTemp,
  //   "avg_humidity": operation.avgHumidity
  // }
  @override
  State<OperationPage> createState() => _OperationPageState();
}

class _OperationPageState extends State<OperationPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<GetOperationCubit>(context)
        .getOperation(widget.operationId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            const TitleAppBar(withReturn: true),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 19),
              child: BlocConsumer<GetOperationCubit, GetOperationState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is LoadingState) {
                      return SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.9,
                        width: MediaQuery.sizeOf(context).width,
                        child: const Center(
                          child: LoadingWidget(),
                        ),
                      );
                    }
                    if (state is GotOperationState) {
                      OperationModel operation = state.operation;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitleDivider(
                              "${operation.type.capitalize()} Operation"),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 22,
                                    child: Image.asset(
                                        "assets/icons/shield_small.png"),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    operation.safetyStatus == 1
                                        ? "Safe"
                                        : "Not Safe",
                                    style:
                                        const TextStyle(color: Colors.black87),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                      width: 8 * 2,
                                      height: 8 * 2,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color.fromARGB(255, 60, 206, 55),
                                      )),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Online",
                                    style:
                                        TextStyle(color: Colors.grey.shade400),
                                  )
                                ],
                              ),
                            ],
                          ),
                          operation.sensorReadings != null
                              ? SfCartesianChart(
                                  legend: Legend(
                                      isVisible: true,
                                      alignment: ChartAlignment.center,
                                      position: LegendPosition.bottom),
                                  title: ChartTitle(
                                      text: 'Sensor Data',
                                      textStyle: const TextStyle(fontSize: 12)),
                                  primaryXAxis: DateTimeAxis(),
                                  series: <ChartSeries>[
                                      // Renders line chart
                                      LineSeries<SensorReadingModel, DateTime>(
                                          dataSource: operation.sensorReadings!,
                                          enableTooltip: true,
                                          dataLabelSettings:
                                              const DataLabelSettings(
                                                  isVisible: true),
                                          name: "Temp",
                                          xValueMapper:
                                              (SensorReadingModel point, _) =>
                                                  point.readAt,
                                          yValueMapper:
                                              (SensorReadingModel point, _) =>
                                                  point.temperature),
                                      LineSeries<SensorReadingModel, DateTime>(
                                          name: "Humidity",
                                          enableTooltip: true,
                                          color: Colors.green,
                                          dataLabelSettings:
                                              const DataLabelSettings(
                                                  isVisible: true),
                                          dataSource: operation.sensorReadings!,
                                          xValueMapper:
                                              (SensorReadingModel point, _) =>
                                                  point.readAt,
                                          yValueMapper:
                                              (SensorReadingModel point, _) =>
                                                  point.humidity)
                                    ])
                              : const SizedBox.shrink(),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Numeric values",
                            style:
                                TextStyle(color: Colors.black87, fontSize: 20),
                          ),
                          Divider(
                            color: Colors.grey.shade400,
                            thickness: 2,
                            endIndent: 30,
                          ),
                          const SizedBox(height: 10),
                          _TableSection(operation, widget.data),
                          const SizedBox(height: 30),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: GradientButton(
                              onPressed: () async {
                                final either = await DI
                                    .di<OperationRepositories>()
                                    .endOperation(operation.id);
                                either.fold((l) {
                                  Fluttertoast.showToast(msg: "Error: ${getErrorMessage(l)}");
                                }, (r) {
                                  Fluttertoast.showToast(
                                      msg: "Ended Operation");
                                      BlocProvider.of<getAll.GetAllOperationsCubit>(context).getAllOperations();
                                });
                              },
                              title: "End operation",
                              withArrow: false,
                            ),
                          ),
                          const SizedBox(height: 40),
                        ],
                      );
                    } else if (state is ErrorState) {
                      return SizedBox(
                          height: MediaQuery.sizeOf(context).height,
                          width: MediaQuery.sizeOf(context).width,
                          child: Center(
                            child: ErrorOccurredTextWidget(
                                errorType: ErrorType.server,
                                message: state.message,
                                fun: () =>
                                    BlocProvider.of<GetOperationCubit>(context)
                                        .getOperation(widget.operationId)),
                          ));
                    }
                    return SizedBox(
                        height: MediaQuery.sizeOf(context).height,
                        width: MediaQuery.sizeOf(context).width,
                        child: const Center(
                          child: ErrorOccurredTextWidget(
                              errorType: ErrorType.server),
                        ));
                  }),
            ),
          ],
        ),
      )),
    );
  }
}

class _TableSection extends StatelessWidget {
  const _TableSection(this.operation, this.data);
  final OperationModel operation;
  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.symmetric(),
      children: [
        const TableRow(
          decoration: BoxDecoration(border: Border.symmetric()),
          children: [
            TableCell(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 3, 0, 10),
                child: Text(''),
              ),
            ),
            TableCell(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 3, 0, 10),
                child: Text('Last'),
              ),
            ),
            TableCell(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 3, 0, 10),
                child: Text('Avg'),
              ),
            ),
          ],
        ),
        TableRow(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            border: const Border(
              top: BorderSide(width: 1, color: Colors.grey),
              bottom: BorderSide(width: 1, color: Colors.grey),
            ),
          ),
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: TableCell(
                child: Text('Temp'),
              ),
            ),
            TableCell(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Text(data["last_temp"].toString()),
              ),
            ),
            TableCell(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Text(data["last_humidity"].toString()),
              ),
            ),
          ],
        ),
        TableRow(
          children: [
            const TableCell(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Text('Humidity'),
              ),
            ),
            TableCell(
                child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Text(data["avg_temp"].toString()),
            )),
            TableCell(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Text(data["avg_humidity"].toString()),
              ),
            ),
            // TableCell(
            //   child: Padding(
            //     padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            //     child: Text(
            //         values.isEmpty ? "" : values[5].toString().substring(0, 4)),
            //   ),
            // ),
          ],
        ),
      ],
    );
  }
}
