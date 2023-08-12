import 'dart:convert';

import 'package:http/http.dart';
import 'package:storage_guard/app/di.dart';
import 'package:storage_guard/core/network/data_source.dart';
import 'package:storage_guard/core/network/urls.dart';
import 'package:storage_guard/features/operation/data/operation_model.dart';

class OperationDataSource {
  final Client _client;
  OperationDataSource(this._client);

  Future<OperationModel> createOperation(Map<String, dynamic> data) async =>
      dataSource(
          () => _client.post(
                Uri.parse(operationsUrl),
                body: json.encode(data),
                headers: {
                  'Accept': 'application/json',
                  'Content-Type': 'application/json',
                  'Authorization': 'Bearer ${DI.userService.getUser()?.token}'
                },
              ),
          model: operationModelFromJson);

  Future<List<OperationModel>> getAllOperations() async => dataSource(
      () => _client.get(
            Uri.parse(operationsUrl),
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json',
              'Authorization': 'Bearer ${DI.userService.getUser()?.token}'
            },
          ),
      model: operationModelListFromJson);

  Future<OperationModel> getOperation(int operationId) async => dataSource(
      () => _client.get(
            Uri.parse(operationUrl(operationId)),
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json',
              'Authorization': 'Bearer ${DI.userService.getUser()?.token}'
            },
          ),
      model: operationModelFromJson);

  Future<void> sendSensorRecordings(
          List<Map<String, dynamic>> data, int operationId) async =>
      dataSource(
        () => _client.post(
          Uri.parse(operationSensorRecordingsUrl(operationId)),
          body: json.encode({"readings": data}),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${DI.userService.getUser()?.token}'
          },
        ),
      );
  Future<void> endOperation(int operationId) async {
    print("EndOperationData:${operationUrl(operationId)}${{
      "finished_at": DateTime.now().millisecondsSinceEpoch.toString()
    }}");
    return dataSource(
      () => _client.put(
        Uri.parse(operationUrl(operationId)),
        body: json.encode(
            {"finished_at": DateTime.now().toIso8601String()}),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${DI.userService.getUser()?.token}'
        },
      ),
    );
  }
}
