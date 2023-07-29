import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';
import 'package:storage_guard/features/operation/sensor.dart';

class BluetoothService {
  FlutterBluetoothSerial bluetooth = FlutterBluetoothSerial.instance;
  BluetoothConnection? connection;
  String data = '';

  BehaviorSubject<List<BluetoothDevice>> devicesStreamController =
      BehaviorSubject<List<BluetoothDevice>>();
  BehaviorSubject<String> dataStreamController = BehaviorSubject<String>();

  Future<bool> requestBluetoothPermission() async {
    PermissionStatus permissionstatus =
        await Permission.bluetoothConnect.status;
    if (permissionstatus.isDenied) {
      Permission.bluetooth.request();
      Permission.bluetoothConnect.request();
      Permission.bluetoothScan.request();
    }

    return permissionstatus.isGranted;
  }

  Future<void> getPairedDevices() async {
    List<BluetoothDevice> pairedDevices = await bluetooth.getBondedDevices();
    devicesStreamController.sink.add(pairedDevices);
  }

  Future<bool> checkBluetoothTurnedOn() async =>
      await bluetooth.isEnabled ?? false;

  Future<bool?> enableBluetooth() async =>
      FlutterBluetoothSerial.instance.requestEnable();

  Future<void> connectToDevice(String address) async {
    connection = await BluetoothConnection.toAddress(address);
    connection!.input?.listen((value) {
      
      data = String.fromCharCodes(value);
      print("SecondDataIS:$data");
      dataStreamController.sink.add(data);
    }).onDone(() {
      connection!.dispose();
      connection = null;
    });
  }

  get devicesStream => devicesStreamController.stream;
  get dataStream => dataStreamController.stream;

  void dispose() {
    devicesStreamController.close();
    dataStreamController.close();
  }
}
