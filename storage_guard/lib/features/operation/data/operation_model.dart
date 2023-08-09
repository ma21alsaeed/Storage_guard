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
  int? userId;
  User? user;
  List<ProductModel>? products;
  List<SensorReadingModel>? sensorReadings;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime? finishedAt;
  double? lastTemp;
  double? lastHumidity;
  double? avgTemp;
  double? avgHumidity;
  int? safetyStatus;
  int? productsCount;
  int? readingsCount;

  OperationModel({
    required this.id,
    required this.type,
    required this.name,
    this.userId,
    this.user,
    this.products,
    this.sensorReadings,
    required this.createdAt,
    required this.updatedAt,
    this.finishedAt,
    this.lastTemp,
    this.lastHumidity,
    this.avgTemp,
    this.avgHumidity,
    this.safetyStatus,
    this.productsCount,
    this.readingsCount,
  });

  factory OperationModel.fromJson(Map<String, dynamic> json) => OperationModel(
        id: json["id"],
        type: json["type"],
        name: json["name"],
        userId: json["user_id"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        products: json["products"] == null
            ? null
            : List<ProductModel>.from(
                json["products"].map((x) => ProductModel.fromJson(x))),
        sensorReadings: json["sensor_readings"] == null
            ? null
            : List<SensorReadingModel>.from(json["sensor_readings"]
                .map((x) => SensorReadingModel.fromJson(x))),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        finishedAt: json["finished_at"] == null
            ? null
            : DateTime.parse(json["finished_at"]),
        lastTemp: json["last_temp"] != null
            ? double.parse(json["last_temp"].toString())
            : null,
        lastHumidity: json["last_humidity"] != null
            ? double.parse(json["last_humidity"].toString())
            : null,
        avgTemp: json["avg_temp"] != null
            ? double.parse(json["avg_temp"].toString())
            : null,
        avgHumidity: json["avg_humidity"] != null
            ? double.parse(json["avg_humidity"].toString())
            : null,
        safetyStatus: json["safety_status"],
        productsCount: json["products_count"],
        readingsCount: json["readings_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "name": name,
        "user_id": userId,
        "user": user?.toJson(),
        "products": products == null
            ? null
            : List<dynamic>.from(products!.map((x) => x.toJson())),
        "sensor_readings": sensorReadings == null
            ? null
            : List<dynamic>.from(sensorReadings!.map((x) => x.toJson())),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "finished_at": finishedAt?.toIso8601String(),
        "last_temp": lastTemp,
        "last_humidity": lastHumidity,
        "avg_temp": avgTemp,
        "avg_humidity": avgHumidity,
        "safety_status": safetyStatus,
        "products_count": productsCount,
        "readings_count": readingsCount,
      };
  bool checkForValues() =>
      lastTemp != null &&
      lastHumidity != null &&
      avgTemp != null &&
      avgHumidity != null;
}
