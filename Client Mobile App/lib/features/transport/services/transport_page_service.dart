import 'package:flutter/material.dart';
import 'package:storage_guard/app/di.dart';

class TransportPageService extends ChangeNotifier {
  List<int> _packagesIdList = [];
  int? _operationId;

  List<int> get packagesIdList => _packagesIdList;

  set packagesIdList(List<int> value) {
    _packagesIdList = value;
    notifyListeners();
  }

  void addToPackagesIdList(int packageId) {
    _packagesIdList.add(packageId);
    notifyListeners();
  }

  int? get getOperationId => _operationId;

  set setOperationId(int? value) {
    _operationId = value;
    notifyListeners();
  }

  String? getConnectedDeviceName() {
    //function returns null if device is not connected
    if (DI.bluetoothService.connection != null &&
        DI.bluetoothService.connection!.isConnected) {
      return DI.bluetoothService.deviceName;
    }
    return null;
  }

  bool createdOperation() => _operationId != null;
  bool addedPackages() => _packagesIdList.isNotEmpty;
}
