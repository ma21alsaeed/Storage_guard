#include "api_services.h"

ApiServices::ApiServices(const char* baseEndPoint) {
  _baseEndPoint = baseEndPoint;
 
}
void ApiServices::setOperationId(int operationId) {
  _operationId = operationId;
}
void ApiServices::setToken(String token) {
  _token = token;
}

bool ApiServices::addSensorData(float temperature, float humidity, String datetime) {
  HTTPClient http;
  WiFiClient client;
  StaticJsonDocument<200> jsonDoc;
  JsonArray readings = jsonDoc.createNestedArray("readings");
  JsonObject reading = readings.createNestedObject();
  reading["temperature"] = temperature;
  reading["humidity"] = humidity;
  reading["read_at"] = datetime;
  String payload;
  serializeJson(jsonDoc, payload);
  http.begin(client, String(_baseEndPoint) + String(_operationId));
  http.addHeader("Content-Type", "application/json");
  http.addHeader("Authorization", String(_token));
  Serial.println(payload);
  int httpResponseCode = http.POST(payload);
  Serial.println(httpResponseCode);
  http.end();
  if (httpResponseCode == 200) {
    return true;
  }
  else {
    return false;
  }
}
