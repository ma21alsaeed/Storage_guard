// To parse this JSON data, do
//
//     final sensorReadingModel = sensorReadingModelFromJson(jsonString);

import 'dart:convert';

SensorReadingModel sensorReadingModelFromJson(String str) => SensorReadingModel.fromJson(json.decode(str));

String sensorReadingModelToJson(SensorReadingModel data) => json.encode(data.toJson());

class SensorReadingModel {
    int id;
    int operationId;
    int temperature;
    int humidity;
    DateTime readAt;

    SensorReadingModel({
        required this.id,
        required this.operationId,
        required this.temperature,
        required this.humidity,
        required this.readAt,
    });

    factory SensorReadingModel.fromJson(Map<String, dynamic> json) => SensorReadingModel(
        id: json["id"],
        operationId: json["operation_id"],
        temperature: json["temperature"],
        humidity: json["humidity"],
        readAt: DateTime.parse(json["read_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "operation_id": operationId,
        "temperature": temperature,
        "humidity": humidity,
        "read_at": readAt.toIso8601String(),
    };
}
