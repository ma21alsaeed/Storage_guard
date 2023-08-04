import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:storage_guard/app/di.dart';
import 'package:storage_guard/app/widgets/error_occurred_widget.dart';
import 'package:storage_guard/app/widgets/title_appbar.dart';
import 'package:storage_guard/features/operation/presentation/sensor_data_page.dart';
import 'package:storage_guard/app/widgets/loading_widget.dart';

class BluetoothDevicesPage extends StatelessWidget {
  const BluetoothDevicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              TitleAppBar(
                withReturn: true,
              ),
              SizedBox(height: 20),
              BluetoothDevicesWidget()
            ],
          ),
        ),
      ),
    );
  }
}

class BluetoothDevicesWidget extends StatefulWidget {
  const BluetoothDevicesWidget({super.key, this.warehouseData});
  final Map<String, dynamic>? warehouseData;
  @override
  State<BluetoothDevicesWidget> createState() => _BluetoothDevicesWidgetState();
}

class _BluetoothDevicesWidgetState extends State<BluetoothDevicesWidget> {
  bool isBluetoothOn = false;
  @override
  void initState() {
    checkBluetoothEnabled();
    DI.bluetoothService.getPairedDevices();
    super.initState();
  }

  void checkBluetoothEnabled() async {
    isBluetoothOn = await DI.bluetoothService.checkBluetoothTurnedOn();
    if (mounted) {
      setState(() {
        print("setting state");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isBluetoothOn
        ? StreamBuilder<List<BluetoothDevice>>(
            stream: DI.bluetoothService.devicesStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<BluetoothDevice> devices = snapshot.data!;
                return RefreshIndicator(
                  onRefresh: () => DI.bluetoothService.getPairedDevices(),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: devices.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(devices[index].name ?? "ESP32_DHT"),
                        onTap: () {
                          widget.warehouseData == null
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SensorDataScreen(
                                        device: devices[index]),
                                  ),
                                )
                              : Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          LoadingPageWithHandler(
                                            handlerText: "Make sure you get Linked Successful message if you don't try again",
                                            () async {
                                              await DI.bluetoothService
                                                  .connectToDevice(
                                                      devices[index].address,devices[index].name??"",
                                                      warehouseConnection: true)
                                                  .then((value) {
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                              });
                                            },
                                          )));
                        },
                      );
                    },
                  ),
                );
              } else {
                return ErrorOccurredTextWidget(
                  errorType: ErrorType.message,
                    message: "Error Getting Devices",
                    fun: () => DI.bluetoothService.getPairedDevices());
              }
            },
          )
        : ErrorOccurredTextWidget(errorType: ErrorType.message,
            message: "Bluetooth is not Enabled",
            fun: () async {
              bool result =
                  await DI.bluetoothService.enableBluetooth() ?? false;
              if (result) {
                DI.bluetoothService.getPairedDevices();
                setState(() {
                  isBluetoothOn = true;
                });
              }
            },
          );
  }
}
