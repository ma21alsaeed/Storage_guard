import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storage_guard/app/constants/preferences.dart';
import 'package:storage_guard/app/di.dart';
import 'package:storage_guard/features/operation/data/operation_repositories.dart';
import 'package:storage_guard/features/operation/presentation/cubit/send_records_cubit.dart';
import 'package:storage_guard/features/operation/sensor_model.dart';

class BluetoothService {
  final SharedPreferences _preferences;
  final OperationRepositories _operationRepositories;
  BluetoothService(this._preferences, this._operationRepositories);

  FlutterBluetoothSerial bluetooth = FlutterBluetoothSerial.instance;
  BluetoothConnection? connection;
  String data = '';
  late DateTime referenceTime;
  bool isFirstConnection = true;
  String deviceName = '';

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

  Future<void> connectToDevice(String address, String deviceName,
      {bool warehouseConnection = false}) async {
        deviceName = deviceName;
    if (connection != null && connection!.isConnected) {
      print("DISCONNECTING");
      await connection!.close();
      isFirstConnection = true;
      await Future.delayed(const Duration(seconds: 1));
      connectToDevice(address, deviceName,
          warehouseConnection: warehouseConnection);
    }
    connection = await BluetoothConnection.toAddress(address);
    
    if (warehouseConnection) {
      String data =
          "1,${DI.userService.getUser()!.token},${DateTime.now().millisecondsSinceEpoch.toString()}";
      print(data);
      connection!.output.add(Uint8List.fromList(utf8.encode(data)));
      await connection!.output.allSent;
      connection!.input?.listen((value) async {
        data = String.fromCharCodes(value);
        print("RawBluetoothDataIs:$data");
        if (data == DI.userService.getUser()!.token) {
          Fluttertoast.showToast(msg: "Linked Successful");
        }
        Fluttertoast.showToast(msg: "Linked Unsuccessful, Please try again");
        connection!.close();
      }).onDone(() {
        connection!.dispose();
        connection = null;
        isFirstConnection = true;
      });
    } else {
      connection!.input?.listen((value) async {
        data = String.fromCharCodes(value);
        print("RawBluetoothDataIs:$data");
        await processData();
      }).onDone(() {
        connection!.dispose();
        connection = null;
        isFirstConnection = true;
      });
    }
  }

  Future<void> processData() async {
    if (data.length > 3) {
      if (!isFirstConnection) {
        //Getting SensorModel from bluetooth data
        var stringModel = sensorModelFromString(data, referenceTime);
        //Getting json from model to send to api
        var jsonModel = sensorModelToJson(stringModel);
        //adding data to show in ui streamBuilder
        dataStreamController.sink.add(data);
        //Check SensorModel list in memory to send the unsent values
        await sendUnsentModels();
        //Send data to api
        DI.di<SendRecordsCubit>().sendSensorRecordings([jsonModel]);
      } else {
        referenceTime =
            DateTime.now().subtract(Duration(microseconds: int.parse(data)));
        isFirstConnection = false;
      }
    }
  }

  Future<void> sendUnsentModels() async {
    List<SensorModel> memoryList = sensorModelListFromJson(
        _preferences.getString(Preferences.sensorReadingsKey));
    //for each SensorModel in memory check if wasSent value is false
    //if wasSent=false resend the value then add the result to the memory list
    for (int i = 0; i < memoryList.length; i++) {
      SensorModel sensorModel = memoryList[i];
      if (!sensorModel.wasSent) {
        final either = await _operationRepositories
            .sendSensorRecordings([sensorModelToJson(sensorModel)]);
        either.fold((error) {}, (data) {
          sensorModel.wasSent = true;
          memoryList[i] = sensorModel;
          String jsonSensorModelList = sensorModelListToJson(memoryList);
          _preferences.setString(
              Preferences.sensorReadingsKey, jsonSensorModelList);
        });
      }
    }
  }

  get devicesStream => devicesStreamController.stream;
  get dataStream => dataStreamController.stream;

  void dispose() {
    devicesStreamController.close();
    dataStreamController.close();
  }
}
