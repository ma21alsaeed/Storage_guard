// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

import 'package:storage_guard/features/operation/data/operation_model.dart';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str), false);
ProductModel productModelFromJsonWithProductKey(String str) =>
    ProductModel.fromJson(json.decode(str), true);
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
  List<OperationModel>? operations;

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

  factory ProductModel.fromJson(
          Map<String, dynamic> json, bool withProductKey) =>
      ProductModel(
        id: withProductKey ? json["product"]["id"] : json["id"],
        name: withProductKey ? json["product"]["name"] : json["name"],
        description: withProductKey
            ? json["product"]["description"]
            : json["description"],
        productionDate: DateTime.parse(withProductKey
            ? json["product"]["production_date"]
            : json["production_date"]),
        expiryDate: DateTime.parse(withProductKey
            ? json["product"]["expiry_date"]
            : json["expiry_date"]),
        maxTemp:
            withProductKey ? json["product"]["max_temp"] : json["max_temp"],
        minTemp:
            withProductKey ? json["product"]["min_temp"] : json["min_temp"],
        maxHumidity: withProductKey
            ? json["product"]["max_humidity"]
            : json["max_humidity"],
        minHumidity: withProductKey
            ? json["product"]["min_humidity"]
            : json["min_humidity"],
        safetyStatus: withProductKey
            ? json["product"]["safety_status"]
            : json["safety_status"],
        createdAt: DateTime.parse(withProductKey
            ? json["product"]["created_at"]
            : json["created_at"]),
        updatedAt: DateTime.parse(withProductKey
            ? json["product"]["updated_at"]
            : json["updated_at"]),
        operations: json["operations"] != null
            ? List<OperationModel>.from(
                json["operations"].map((x) => OperationModel.fromJson(x)))
            : null,
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
        "operations": operations != null
            ? List<dynamic>.from(operations!.map((x) => x.toJson()))
            : null
      };
  String safeStatus() => safetyStatus == 1 ? "Safe" : "Not Safe";
}
