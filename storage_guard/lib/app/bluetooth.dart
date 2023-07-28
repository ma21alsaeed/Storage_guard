import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';

class BluetoothService {
  FlutterBluetoothSerial bluetooth = FlutterBluetoothSerial.instance;

  BehaviorSubject<List<BluetoothDevice>> devicesStreamController =
      BehaviorSubject<List<BluetoothDevice>>();

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

  get devicesStream => devicesStreamController.stream;

  void dispose() {
    devicesStreamController.close();
  }
}
