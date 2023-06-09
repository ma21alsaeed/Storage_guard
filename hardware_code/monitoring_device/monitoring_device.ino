/*
  #include <SPIFFS.h>
  #include <ArduinoJson.h>

  #include "dht_sensor.h"

  #define DHT_PIN 15
  #define DHT_TYPE DHT11
  #define READ_INTERVAL 2000
  #define SAVE_INTERVAL 10000

  DhtSensor dht_sensor(DHT_PIN, DHT_TYPE);
  unsigned long last_read_time = 0;
  unsigned long last_save_time = 0;

  void setup() {
  Serial.begin(115200);

  // Initialize SPIFFS
  if (!SPIFFS.begin()) {
    Serial.println("Error initializing SPIFFS");
    return;
  }

  // Create a new JSON file
  File file = SPIFFS.open("/data.json", FILE_WRITE);
  if (!file) {
    Serial.println("Error opening file for writing");
    return;
  }

  file.close();
  }

  void loop() {
  // Read the sensor values every READ_INTERVAL milliseconds
  if (millis() - last_read_time >= READ_INTERVAL) {
    dht_sensor.readValues();
    last_read_time = millis();
  }

  // Save the sensor values every SAVE_INTERVAL milliseconds
  if (millis() - last_save_time >= SAVE_INTERVAL) {
    // Open the JSON file for appending
    File file = SPIFFS.open("/data.json", FILE_APPEND);
    if (!file) {
      Serial.println("Error opening file for appending");
      return;
    }

    // Clear the JSON document
    StaticJsonDocument<128> json_doc;
    json_doc.clear();

    // Add the sensor values to the JSON document
    json_doc["temperature"] = dht_sensor.getTemperature();
    json_doc["humidity"] = dht_sensor.getHumidity();



    // Serialize the JSON document to a string and write it to the file
    serializeJson(json_doc, file);
    file.println();

    // Close the file
    file.close();
    Serial.println("Temperature: " + String(json_doc["temperature"].as<float>()));
    Serial.println("Humidity: " + String(json_doc["humidity"].as<float>()));
    last_save_time = millis();
  }
  }
*/

#include "oled.h"
#include "dht_sensor.h"
#define DHT_PIN 15
#define DHT_TYPE DHT11
DhtSensor dht = DhtSensor(DHT_PIN, DHT_TYPE);
OLED oled  = OLED();

void setup()
{

  oled.begin();
  oled.splashScreen();

}


void loop() {
  if (dht.readValues())
  {
    oled.showTempAndHum(dht.getTemperature(), dht.getHumidity());
  }
  else {
    oled.displayLoadingAnimation();
  }

}
