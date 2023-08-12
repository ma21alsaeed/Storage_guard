
import 'package:get/get.dart';

class OperationData {
  int id;
  String type;
  String name;
  int userId;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime? finishedAt;
  double? lastTemp;
  double? lastHumidity;
  double? avgTemp;
  double? avgHumidity;
  int safetyStatus;
  int productsCount;
  int readingsCount;

  OperationData({
    required this.id,
    required this.type,
    required this.name,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
     this.finishedAt,
     this.lastTemp,
     this.lastHumidity,
     this.avgTemp,
     this.avgHumidity,
    required this.safetyStatus,
    required this.productsCount,
    required this.readingsCount,
  });

  factory OperationData.fromJson(Map<String, dynamic> json) => OperationData(
    id: json["id"],
    type: json["type"],
    name: json["name"],
    userId: json["user_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    finishedAt: json["finished_at"]==null?null:DateTime.parse(json["finished_at"]),
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
    "last_temp": lastTemp,
    "last_humidity": lastHumidity,
    "avg_temp": avgTemp,
    "avg_humidity": avgHumidity,
    "safety_status": safetyStatus,
    "products_count": productsCount,
    "readings_count": readingsCount,
  };
}
