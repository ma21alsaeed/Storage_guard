// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

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

    ProductModel({
        required this.id,
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
    });

    factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        productionDate: DateTime.parse(json["production_date"]),
        expiryDate: DateTime.parse(json["expiry_date"]),
        maxTemp: json["max_temp"],
        minTemp: json["min_temp"],
        maxHumidity: json["max_humidity"],
        minHumidity: json["min_humidity"],
        safetyStatus: json["safety_status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
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
    };
}
