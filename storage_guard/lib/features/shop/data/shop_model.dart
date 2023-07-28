// To parse this JSON data, do
//
//     final shopModel = shopModelFromJson(jsonString);

import 'dart:convert';

ShopModel shopModelFromJson(String str) => ShopModel.fromJson(json.decode(str));

String shopModelToJson(ShopModel data) => json.encode(data.toJson());

class ShopModel {
    String humidity;
    String location;
    String phone;
    bool safe;
    String shopName;
    String temperature;

    ShopModel({
        required this.humidity,
        required this.location,
        required this.phone,
        required this.safe,
        required this.shopName,
        required this.temperature,
    });

    factory ShopModel.fromJson(Map<String, dynamic> json) => ShopModel(
        humidity: json["humidity"],
        location: json["location"],
        phone: json["phone"],
        safe: json["safe"],
        shopName: json["shop_name"],
        temperature: json["temperature"],
    );

    Map<String, dynamic> toJson() => {
        "humidity": humidity,
        "location": location,
        "phone": phone,
        "safe": safe,
        "shop_name": shopName,
        "temperature": temperature,
    };
}
