import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:storage_guard/app/di.dart';
import 'package:storage_guard/app/widgets/error_occured_widget.dart';
import 'package:storage_guard/app/widgets/title_appbar.dart';
import 'package:storage_guard/features/operation/presentation/sensor_data_page.dart';

class OperationPage extends StatefulWidget {
  const OperationPage({super.key});

  @override
  State<OperationPage> createState() => _OperationPageState();
}

class _OperationPageState extends State<OperationPage> {
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const TitleAppBar(
                withReturn: true,
              ),
              const SizedBox(height: 20),
              isBluetoothOn
                  ? StreamBuilder<List<BluetoothDevice>>(
                      stream: DI.bluetoothService.devicesStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<BluetoothDevice> devices = snapshot.data!;
                          return RefreshIndicator(
                            onRefresh: () =>
                                DI.bluetoothService.getPairedDevices(),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: devices.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title:
                                      Text(devices[index].name ?? "ESP32_DHT"),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SensorDataScreen(
                                            device: devices[index]),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          );
                        } else {
                          return ErrorOccuredTextWidget(
                              message: "Error Getting Devices",
                              fun: () =>
                                  DI.bluetoothService.getPairedDevices());
                        }
                      },
                    )
                  : ErrorOccuredTextWidget(
                      message: "Bluetooth is not Enabled",
                      fun: () async {
                        bool result =
                            await DI.bluetoothService.enableBluetooth() ??
                                false;
                        if (result) {
                          DI.bluetoothService.getPairedDevices();
                          setState(() {
                            isBluetoothOn = true;
                          });
                        }
                      },
                    )
            ],
          ),
        ),
      ),
    );
  }
}
