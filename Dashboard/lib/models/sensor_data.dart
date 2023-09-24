import 'dart:convert';
class SensorData {
  int id;
  int operationId;
  double temperature;
  double humidity;
  DateTime readAt;

  SensorData({
    required this.id,
    required this.operationId,
    required this.temperature,
    required this.humidity,
    required this.readAt,
  });

  factory SensorData.fromJson(Map<String, dynamic> json) => SensorData(
    id: json["id"],
    operationId: json["operation_id"],
    temperature: json["temperature"],
    humidity: json["humidity"],
    readAt: DateTime.parse(json["read_at"]),
  );

  Map<String, dynamic> toJson() => {
    "operation_id": operationId,
    "temperature": temperature,
    "humidity": humidity,
    "read_at": readAt.toIso8601String(),
  };
}
