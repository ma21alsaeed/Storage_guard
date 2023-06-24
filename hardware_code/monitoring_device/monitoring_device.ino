#include <LITTLEFS.h>
#include <ArduinoJson.h>
#include "dht_sensor.h"

#define DHT_PIN 15
#define DHT_TYPE DHT11
#define READ_INTERVAL 2000

DhtSensor dht_sensor(DHT_PIN, DHT_TYPE);
unsigned long last_read_time = 0;

void setup() {
  Serial.begin(115200);

  // Initialize LITTLEFS
  if (!LITTLEFS.begin()) {
    Serial.println("Error initializing LITTLEFS");
    return;
  }

  // Open the JSON file
  File file = LITTLEFS.open("/data2.json", "r");
  if (!file) {
    Serial.println("Error opening file");
    return;
  }

  // Read the contents of the file and print it to the serial monitor
  while (file.available()) {
    Serial.write(file.read());
  }

  // Close the file
  file.close();
}

void loop() {
  // Read the sensor values every READ_INTERVAL milliseconds
  if (millis() - last_read_time >= READ_INTERVAL) {
    dht_sensor.readValues();
    last_read_time = millis();

    // Open the JSON file for appending
    File file = LITTLEFS.open("/data2.json", "a");


    // Parse the existing JSON content in the file
    DynamicJsonDocument json_doc(512);

    // Read the existing JSON content in the file
    if (file.size() > 0) {
      DeserializationError error = deserializeJson(json_doc, file);
      if (error) {
        Serial.println("Error parsing JSON");
        file.close();
        return;
      }
    }

    // Add the sensor values to the JSON document
    JsonObject sensor_data = json_doc.createNestedObject();
    sensor_data["timestamp"] = millis();
    sensor_data["temperature"] = dht_sensor.getTemperature();
    sensor_data["humidity"] = dht_sensor.getHumidity();

    // Serialize the JSON document to a string and write it to the file
    serializeJson(json_doc, file);
    file.println();

    // Close the file
    file.close();

    //Serial.println("Temperature: " + String(sensor_data["temperature"].as<float>()));
    //Serial.println("Humidity: " + String(sensor_data["humidity"].as<float>()));

    // Open the JSON file again to read and print its contents
    file = LITTLEFS.open("/data2.json", "r");


    // Read the contents of the file and print it to the serial monitor

      Serial.write(file.read());
 

    // Close the file
    file.close();
  }
}
/*
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

}*/
