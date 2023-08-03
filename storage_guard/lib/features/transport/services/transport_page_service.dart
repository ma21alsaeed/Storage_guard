import 'package:flutter/material.dart';

class TransportPageService extends ChangeNotifier {
  List<int> _packagesIdList = [1];
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

  int? get operationId => _operationId;

  set operationId(int? value) {
    _operationId = value;
    notifyListeners();
  }

  bool createdOperation() => _operationId != null;
  bool addedPackages() => _packagesIdList.isNotEmpty;
}
