// To parse this JSON data, do
//
//     final operationModel = operationModelFromJson(jsonString);

import 'dart:convert';

import 'package:storage_guard/features/authentication/data/user_model.dart';
import 'package:storage_guard/features/operation/data/sensor_reading_model.dart';
import 'package:storage_guard/features/product/data/product_model.dart';

OperationModel operationModelFromJson(String str) =>
    OperationModel.fromJson(json.decode(str)["data"]);

String operationModelToJson(OperationModel data) => json.encode(data.toJson());

List<OperationModel> operationModelListFromJson(String str) =>
    List<OperationModel>.from(
        json.decode(str)["data"].map((x) => OperationModel.fromJson(x)));

String operationModelListToJson(List<OperationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OperationModel {
    int id;
    String type;
    String name;
    int userId;
    DateTime createdAt;
    DateTime updatedAt;
    dynamic finishedAt;
    int lastTemp;
    int lastHumidity;
    int avgTemp;
    int avgHumidity;
    int safetyStatus;
    int productsCount;
    int readingsCount;

    OperationModel({
        required this.id,
        required this.type,
        required this.name,
        required this.userId,
        required this.createdAt,
        required this.updatedAt,
        this.finishedAt,
        required this.lastTemp,
        required this.lastHumidity,
        required this.avgTemp,
        required this.avgHumidity,
        required this.safetyStatus,
        required this.productsCount,
        required this.readingsCount,
    });

    factory OperationModel.fromJson(Map<String, dynamic> json) => OperationModel(
        id: json["id"],
        type: json["type"],
        name: json["name"],
        userId: json["user_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        finishedAt: json["finished_at"],
        lastTemp: json["last_temp"],
        lastHumidity: json["last_humidity"],
        avgTemp: json["avg_temp"],
        avgHumidity: json["avg_humidity"],
        safetyStatus: json["safety_status"],
        productsCount: json["products_count"],
        readingsCount: json["readings_count"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "name": name,
        "user_id": userId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "finished_at": finishedAt,
        "last_temp": lastTemp,
        "last_humidity": lastHumidity,
        "avg_temp": avgTemp,
        "avg_humidity": avgHumidity,
        "safety_status": safetyStatus,
        "products_count": productsCount,
        "readings_count": readingsCount,
    };
}