import 'dart:convert';

import 'package:http/http.dart';
import 'package:storage_guard/app/di.dart';
import 'package:storage_guard/core/network/data_source.dart';
import 'package:storage_guard/core/network/urls.dart';
import 'package:storage_guard/features/operation/data/operation_model.dart';

class OperationDataSource {
  final Client _client;
  OperationDataSource(this._client);

  Future<List<OperationModel>> getAllOperations() async =>
      dataSource(
        () => _client.get(
          Uri.parse(getOperationsUrl),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${DI.userService.getUser()?.token}'
          },
        ),model: operationModelListFromJson
      );

  Future<void> sendSensorRecordings(List<Map<String, dynamic>> data) async =>
      dataSource(
        () => _client.post(
          Uri.parse(operationSensorRecordingsUrl(1)),
          body: json.encode({"readings": data}),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${DI.userService.getUser()?.token}'
          },
        ),
      );
}
