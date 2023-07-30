Map<String, dynamic> sensorModelToJson(SensorModel data) => data.toJson();
SensorModel sensorModelFromString(String data, DateTime referenceTime) =>
    SensorModel.fromString(data, referenceTime);
SensorModel sensorModelFromJson(Map<String, dynamic> data, bool wasSent) =>
    SensorModel(
        temperature: data, humidity: data, timeStamp: data, wasSent: wasSent);

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

  Map<String, dynamic> toJson() => {
        "readings": [
          {
            "temperature": temperature,
            "humidity": humidity,
            "read_at": timeStamp
          }
        ]
      };
}
