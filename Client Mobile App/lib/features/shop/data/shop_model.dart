// To parse this JSON data, do
//
//     final shopModel = shopModelFromJson(jsonString);

import 'dart:convert';

import 'package:storage_guard/features/authentication/data/user_model.dart';
import 'package:storage_guard/features/operation/data/operation_model.dart';


ShopModel shopModelFromJson(String str) => ShopModel.fromJson(json.decode(str));

String shopModelToJson(ShopModel data) => json.encode(data.toJson());

class ShopModel {
  User user;
  List<OperationModel> operations;

  ShopModel({required this.user, required this.operations});

  factory ShopModel.fromJson(Map<String, dynamic> json) => ShopModel(
        user: User.fromJson(json["user"]),
        operations: List<OperationModel>.from(
            json["data"].map((x) => OperationModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "data": List<dynamic>.from(operations.map((x) => x.toJson()))
      };
  bool getIsSafe() {
    bool isSafe = true;
    for (OperationModel operation in operations) {
      if (operation.safetyStatus == 0) {
        isSafe = false;
        break;
      }
    }
    return isSafe;
  }
}
