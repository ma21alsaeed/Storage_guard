// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  String expirationDate;
  List<Log> logs;
  String manufacturedBy;
  String productName;
  String productionDate;
  bool safe;

  ProductModel({
    required this.expirationDate,
    required this.logs,
    required this.manufacturedBy,
    required this.productName,
    required this.productionDate,
    required this.safe,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        expirationDate: json["expiration_date"],
        logs: List<Log>.from(json["logs"].map((x) => Log.fromJson(x))),
        manufacturedBy: json["manufactured_by"],
        productName: json["product_name"],
        productionDate: json["production_date"],
        safe: json["safe"],
      );

  Map<String, dynamic> toJson() => {
        "expiration_date": expirationDate,
        "logs": List<dynamic>.from(logs.map((x) => x.toJson())),
        "manufactured_by": manufacturedBy,
        "product_name": productName,
        "production_date": productionDate,
        "safe": safe,
      };
}

class Log {
  String endDate;
  bool safe;
  String startDate;
  String type;

  Log({
    required this.endDate,
    required this.safe,
    required this.startDate,
    required this.type,
  });

  factory Log.fromJson(Map<String, dynamic> json) => Log(
        endDate: json["end_date"],
        safe: json["safe"],
        startDate: json["start_date"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "end_date": endDate,
        "safe": safe,
        "start_date": startDate,
        "type": type,
      };
  String getDate() {
    List startList = startDate.split("/");
    List endList = endDate.split("/");
    return startList[1].trim() +
        "/" +
        startList[2].trim() +
        "-" +
        endList[1].trim() +
        "/" +
        endList[2].trim();
  }
  // [2024 ,  01 ,  03]
}
