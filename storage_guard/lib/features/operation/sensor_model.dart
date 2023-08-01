import 'dart:convert';

Map<String, dynamic> sensorModelToJson(SensorModel data, {bool? wasSent}) =>
    data.toJson(wasSent: wasSent);

SensorModel sensorModelFromString(String data, DateTime referenceTime) =>
    SensorModel.fromString(data, referenceTime);

String sensorModelListToJson(List<SensorModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<SensorModel> sensorModelListFromJson(String? str) => str == null
    ? []
    : List<SensorModel>.from(json
        .decode(str)
        .map((x) => sensorModelFromBasicJson(x, x["was_sent"])));

SensorModel sensorModelFromBasicJson(Map<String, dynamic> data, bool wasSent) =>
    SensorModel(
        temperature: data["temperature"],
        humidity: data["humidity"],
        timeStamp: data["read_at"],
        wasSent: wasSent);

class SensorModel {
  SensorModel(
      {required this.temperature,
      required this.humidity,
      required this.timeStamp,
      this.wasSent = false});
  double temperature;
  double humidity;
  DateTime timeStamp;
  bool wasSent;

  factory SensorModel.fromString(String data, DateTime referenceTime) =>
      SensorModel(
          temperature: double.parse(data.substring(0, 4)),
          humidity: double.parse(data.substring(6, 10)),
          timeStamp: referenceTime.add(Duration(
              milliseconds: int.parse(data.substring(12, data.length)))));

  Map<String, dynamic> toJson({bool? wasSent}) => wasSent != null
      ? {
          "temperature": temperature,
          "humidity": humidity,
          "read_at": timeStamp,
          "was_sent": wasSent
        }
      : {
          "temperature": temperature,
          "humidity": humidity,
          "read_at": timeStamp
        };
}
