import 'dart:convert';

import 'package:http/http.dart';
import 'package:storage_guard/core/network/data_source.dart';
import 'package:storage_guard/core/network/urls.dart';
import 'package:storage_guard/features/authentication/data/user_model.dart';
class AuthDataSource {
  final Client _client;
  AuthDataSource(this._client);
  Future<UserModel> login(Map<String, dynamic> data) async {
    return dataSource(
      () => _client.post(
        Uri.parse(loginUrl),
        body: json.encode(data),
        headers: {
          'Content-Type': 'application/json',
        },
      ),
      // model: userModelFromJson
    );
  }
  Future<UserModel> register(Map<String, dynamic> data) async {
    return dataSource(
      () => _client.post(
        Uri.parse(registerUrl),
        body: json.encode(data),
        headers: {
          'Content-Type': 'application/json',
        },
      ), 
      // model: userModelFromJson
    );
  }
}
