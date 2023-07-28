import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:storage_guard/app/widgets/title_divider.dart';
import 'package:storage_guard/features/operation/sensor.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SensorDataScreen extends StatefulWidget {
  final BluetoothDevice device;

  SensorDataScreen({required this.device});

  @override
  _SensorDataScreenState createState() => _SensorDataScreenState();
}

class _SensorDataScreenState extends State<SensorDataScreen> {
  String data = '';
  List<SensorData> listData = [];
  List<Point> points = [];
  List<Point> points2 = [];
  List<double> values = [];
  BluetoothConnection? connection;

  @override
  void initState() {
    super.initState();

    connectToDevice();
  }

  void connectToDevice() async {
    connection = await BluetoothConnection.toAddress(widget.device.address);
    connection!.input?.listen((data) {
      setState(() {
        this.data = String.fromCharCodes(data);

        try {
          listData.add(SensorData(
              temperature: double.parse(this.data.toString().substring(0, 4)),
              humidity: double.parse(this.data.toString().substring(6, 10))));
          points
              .add(Point(x: listData.last.time, y: listData.last.temperature));
          points2.add(Point(x: listData.last.time, y: listData.last.humidity));

          values = getMinMaxAvg(listData);
        } catch (e) {}
      });
    }).onDone(() {
      connection!.dispose();
      connection = null;
    });
  }

  @override
  void dispose() {
    connection?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
        child: Column(
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
                    Icon(Icons.safety_check, color: Colors.blue.shade900),
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
            SizedBox(
              height: 10,
            ),
            _TableSection(values)
          ],
        ),
      ),
    ));
  }
}

class _TableSection extends StatelessWidget {
  const _TableSection(this.values, {super.key});
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
            border: Border(
              top: BorderSide(width: 1, color: Colors.grey),
              bottom: BorderSide(width: 1, color: Colors.grey),
            ),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: TableCell(
                child: Text('Temp'),
              ),
            ),
            TableCell(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Text(values[1].toString().substring(0, 4)),
              ),
            ),
            TableCell(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Text(values[0].toString().substring(0, 4)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: TableCell(
                child: Text(values[2].toString().substring(0, 4)),
              ),
            ),
          ],
        ),
        TableRow(
          children: [
            TableCell(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Text('Humidity'),
              ),
            ),
            TableCell(
                child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Text(values[4].toString().substring(0, 4)),
            )),
            TableCell(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Text(values[3].toString().substring(0, 4)),
              ),
            ),
            TableCell(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Text(values[5].toString().substring(0, 4)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
