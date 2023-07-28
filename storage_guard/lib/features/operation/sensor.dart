class SensorData {
  final double temperature;
  final double humidity;
  final DateTime time;

  SensorData({required this.temperature, required this.humidity})
      : time = DateTime.now();
}

class Point {
  final DateTime x;
  final double y;

  Point({required this.x, required this.y});
}

List<double> getMinMaxAvg(List<SensorData> list) {
  double sumTemp = 0;
  double sumHum = 0;
  double maxTemp = 0;
  double minTemp = double.infinity;
  double maxHum = 0;
  double minHum = double.infinity;

  for (var element in list) {
    double temp = element.temperature;
    double hum = element.humidity;

    // Calculate sum of temperatures and humidities
    sumTemp += temp;
    sumHum += hum;

    // Update maximum and minimum values
    if (temp > maxTemp) {
      maxTemp = temp;
    }
    if (temp < minTemp) {
      minTemp = temp;
    }
    if (hum > maxHum) {
      maxHum = hum;
    }
    if (hum < minHum) {
      minHum = hum;
    }
  }

  // Calculate averages
  double avgTemp = sumTemp / list.length;
  double avgHum = sumHum / list.length;

  return [maxTemp, minTemp, avgTemp, maxHum, minHum, avgHum];
}