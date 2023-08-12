// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

import 'package:storage_guard/features/operation/data/operation_model.dart';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  int id;
  String name;
  String description;
  DateTime productionDate;
  DateTime expiryDate;
  int maxTemp;
  int minTemp;
  int maxHumidity;
  int minHumidity;
  int safetyStatus;
  DateTime createdAt;
  DateTime updatedAt;
  List<OperationModel> operations;

  ProductModel(
      {required this.id,
      required this.name,
      required this.description,
      required this.productionDate,
      required this.expiryDate,
      required this.maxTemp,
      required this.minTemp,
      required this.maxHumidity,
      required this.minHumidity,
      required this.safetyStatus,
      required this.createdAt,
      required this.updatedAt,
      required this.operations});

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["product"]["id"],
        name: json["product"]["name"],
        description: json["product"]["description"],
        productionDate: DateTime.parse(json["product"]["production_date"]),
        expiryDate: DateTime.parse(json["product"]["expiry_date"]),
        maxTemp: json["product"]["max_temp"],
        minTemp: json["product"]["min_temp"],
        maxHumidity: json["product"]["max_humidity"],
        minHumidity: json["product"]["min_humidity"],
        safetyStatus: json["product"]["safety_status"],
        createdAt: DateTime.parse(json["product"]["created_at"]),
        updatedAt: DateTime.parse(json["product"]["updated_at"]),
        operations: List<OperationModel>.from(
            json["operations"].map((x) => OperationModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "production_date": productionDate.toIso8601String(),
        "expiry_date": expiryDate.toIso8601String(),
        "max_temp": maxTemp,
        "min_temp": minTemp,
        "max_humidity": maxHumidity,
        "min_humidity": minHumidity,
        "safety_status": safetyStatus,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "operations": List<dynamic>.from(operations.map((x) => x.toJson()))
      };
  String safeStatus() => safetyStatus == 1 ? "Safe" : "Not Safe";
}
