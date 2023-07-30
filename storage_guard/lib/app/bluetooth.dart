import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';
import 'package:storage_guard/app/di.dart';
import 'package:storage_guard/features/operation/presentation/cubit/send_records_cubit.dart';
import 'package:storage_guard/features/operation/sensor_model.dart';

class BluetoothService {
  FlutterBluetoothSerial bluetooth = FlutterBluetoothSerial.instance;
  BluetoothConnection? connection;
  String data = '';
  late DateTime referenceTime;

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
    bool isFirstConnection = true;
    if (connection?.isConnected ?? false) {
      connection!.close();
      isFirstConnection = true;
    }
    connection = await BluetoothConnection.toAddress(address);
    connection!.input?.listen((value) {
      data = String.fromCharCodes(value);
      print("RawDataIS:$data");
      if (!isFirstConnection) {
        DI.di<SendRecordsCubit>().sendSensorRecordings(sensorModelToJson(sensorModelFromString(data,referenceTime)));
        dataStreamController.sink.add(data);
      } else {
        referenceTime =
            DateTime.now().subtract(Duration(microseconds: int.parse(data)));
        isFirstConnection = false;
      }
    }).onDone(() {
      connection!.dispose();
      connection = null;
      isFirstConnection = true;
    });
  }

  get devicesStream => devicesStreamController.stream;
  get dataStream => dataStreamController.stream;

  void dispose() {
    devicesStreamController.close();
    dataStreamController.close();
  }
}
