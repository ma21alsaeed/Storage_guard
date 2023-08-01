import 'dart:convert';

import 'package:http/http.dart';
import 'package:storage_guard/app/di.dart';
import 'package:storage_guard/core/network/data_source.dart';
import 'package:storage_guard/core/network/urls.dart';

class OperationDataSource {
  final Client _client;
  OperationDataSource(this._client);
  Future<void> sendSensorRecordings(List<Map<String, dynamic>> data) async =>
      dataSource(
        () => _client.post(
          Uri.parse(operationSensorRecodringsUrl),
          body: json.encode({"readings": data}),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${DI.userService.getUser()?.token}'
          },
        ),
      );
}
