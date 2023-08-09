import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:provider/provider.dart';
import 'package:storage_guard/app/di.dart';
import 'package:storage_guard/app/widgets/loading_widget.dart';
import 'package:storage_guard/app/widgets/title_divider.dart';
import 'package:storage_guard/features/operation/sensor.dart';
import 'package:storage_guard/features/transport/services/transport_page_service.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SensorDataScreen extends StatefulWidget {
  final BluetoothDevice device;

  const SensorDataScreen({super.key, required this.device});

  @override
  State<SensorDataScreen> createState() => _SensorDataScreenState();
}

class _SensorDataScreenState extends State<SensorDataScreen> {
  List<SensorData> listData = [];
  List<Point> points = [];
  List<Point> points2 = [];
  List<double>? values = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DI.bluetoothService.connectToDevice(
        widget.device.address, widget.device.name ?? '',
        operationId: Provider.of<TransportPageService>(context,listen: false).getOperationId);
  }

  void getData(String data) async {
    try {
      listData.add(SensorData(
          temperature: double.parse(data.toString().substring(0, 4)),
          humidity: double.parse(data.toString().substring(6, 10))));
      points.add(Point(x: listData.last.time, y: listData.last.temperature));
      points2.add(Point(x: listData.last.time, y: listData.last.humidity));
      values = getMinMaxAvg(listData);
    } catch (e) {
      debugPrint("Error Getting Data Sensor Page");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
        child: StreamBuilder<String>(
            stream: DI.bluetoothService.dataStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                getData(snapshot.data!);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TitleDivider("Storage Operation"),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 22,
                              child:
                                  Image.asset("assets/icons/shield_small.png"),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Text(
                              "Safe",
                              style: TextStyle(color: Colors.black87),
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
                              style: TextStyle(color: Colors.grey.shade400),
                            )
                          ],
                        ),
                      ],
                    ),
                    SfCartesianChart(
                        legend: Legend(
                          title: LegendTitle(text: "Temp"),
                        ),
                        title: ChartTitle(
                            text: 'Sensor Data',
                            textStyle: const TextStyle(fontSize: 12)),
                        primaryXAxis: DateTimeAxis(),
                        series: <ChartSeries>[
                          // Renders line chart
                          LineSeries<Point, DateTime>(
                              dataSource: points,
                              name: "Temp",
                              xValueMapper: (Point point, _) => point.x,
                              yValueMapper: (Point point, _) => point.y),
                          LineSeries<Point, DateTime>(
                              name: "Humidity",
                              color: Colors.green,
                              dataSource: points2,
                              xValueMapper: (Point point, _) => point.x,
                              yValueMapper: (Point point, _) => point.y)
                        ]),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Numeric values",
                      style: TextStyle(color: Colors.black87, fontSize: 20),
                    ),
                    Divider(
                      color: Colors.grey.shade400,
                      thickness: 2,
                      endIndent: 30,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    _TableSection(values ?? [])
                  ],
                );
              } else {
                return SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.9,
                  width: MediaQuery.sizeOf(context).width,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LoadingWidget(),
                    ],
                  ),
                );
              }
            }),
      ),
    ));
  }
}

class _TableSection extends StatelessWidget {
  const _TableSection(this.values);
  final List<double> values;
  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.symmetric(),
      children: [
        const TableRow(
          decoration: BoxDecoration(border: Border.symmetric()),
          children: [
            TableCell(
              child: Text(''),
            ),
            TableCell(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 3, 0, 10),
                child: Text('Min'),
              ),
            ),
            TableCell(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 3, 0, 10),
                child: Text('Max'),
              ),
            ),
            TableCell(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 3, 0, 10),
                child: Text('AVG'),
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
                child: Text(
                    values.isEmpty ? "" : values[1].toString().substring(0, 4)),
              ),
            ),
            TableCell(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Text(
                    values.isEmpty ? "" : values[0].toString().substring(0, 4)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: TableCell(
                child: Text(
                    values.isEmpty ? "" : values[2].toString().substring(0, 4)),
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
              child: Text(
                  values.isEmpty ? "" : values[4].toString().substring(0, 4)),
            )),
            TableCell(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Text(
                    values.isEmpty ? "" : values[3].toString().substring(0, 4)),
              ),
            ),
            TableCell(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Text(
                    values.isEmpty ? "" : values[5].toString().substring(0, 4)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
