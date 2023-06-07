/*
#include "sensor_data.h"
#include "dht_sensor.h"
DhtSensor dht_sensor(15, DHT11);
SensorDataManager sensor_data_manager;
std::vector<SensorData> data1;
void setup() {
  Serial.begin(9600);

sensor_data_manager.addDataPointToEEPROM(25.0, 50.0, 1, 1621477732);

sensor_data_manager.addDataPointToEEPROM(25.0, 50.0, 1, 1621477732);


sensor_data_manager.addDataPointToEEPROM(25.0, 50.0, 1, 1621477732);

}

void loop() {
data1= sensor_data_manager.readAllDataPointsFromEEPROM();


for (SensorData i:data1){
    Serial.println("ss");
    Serial.print(i.temperature);}


}


#include "ArduinoJson.h"
#include <EEPROM.h>
struct MyStruct {
  float temp;
  float hum;
  String timestamp;
  int state;
};

MyStruct myData;
const int capacity = JSON_OBJECT_SIZE(3);
StaticJsonDocument<capacity> doc;

void setup() {



  Serial.begin(9600);
  EEPROM.begin(sizeof(MyStruct)); // initialize EEPROM
  Serial.print(sizeof(MyStruct));
  myData.temp = 42;
  myData.hum = 50;
  myData.timestamp = "4243243532524";
  myData.state = 1;
  
  doc["data"] = myData;
  serializeJsonPretty(doc, Serial);
}

void loop() {
  // read struct from EEPROM

  delay(1000);
}

*/

#include <EEPROM.h>
#include <ArduinoJson.h>

// Define the struct
struct Data {
  int id;
  float value;
};

// Define the EEPROM address where the JSON data will be stored
#define EEPROM_ADDR 0

// Define the maximum number of struct instances that can be stored in the JSON file
#define MAX_INSTANCES 10

// Define the size of each struct instance in bytes
#define INSTANCE_SIZE sizeof(Data)

void setup() {
  // Initialize EEPROM

  Serial.begin(9600);
  EEPROM.begin(512);
  Serial.print(sizeof(Data));

  // Create a JSON array to store the struct instances
  StaticJsonDocument<INSTANCE_SIZE * MAX_INSTANCES> json;

  // Create an array of struct instances
  Data data[MAX_INSTANCES];
  for (int i = 0; i < MAX_INSTANCES; i++) {
    Serial.print(i);
    data[i].id = 6;
    data[i].value = i * 1.5;
    delay(1000);
  }

  // Add the struct instances to the JSON array
  for (int i = 0; i < MAX_INSTANCES; i++) {
    JsonObject obj = json.createNestedObject();
    obj["id"] = data[i].id;
    obj["value"] = data[i].value;
  }

  // Serialize the JSON array to a string
  String jsonString;
  serializeJson(json, jsonString);

  // Write the JSON data to EEPROM
  int address = EEPROM_ADDR;
  for (int i = 0; i < jsonString.length(); i++) {
    EEPROM.write(address++, jsonString[i]);
  }

  // Commit the changes to EEPROM
  EEPROM.commit();
}

void loop() {
  // Read the JSON data from EEPROM
  int address = EEPROM_ADDR;
  String jsonString;
  while (true) {
    char c = EEPROM.read(address++);
    if (c == '\0') {
      break;
    }
    jsonString += c;
  }

  // Parse the JSON data into a JsonDocument
  StaticJsonDocument<INSTANCE_SIZE * MAX_INSTANCES> json;
  deserializeJson(json, jsonString);

  // Print the struct instances
  for (int i = 0; i < MAX_INSTANCES; i++) {
    JsonObject obj = json[i];
    Data data;
    data.id = obj["id"];
    data.value = obj["value"];
    Serial.print("id = ");
    Serial.print(data.id);
    Serial.print(", value = ");
    Serial.println(data.value);
  }

  // Wait for 1 second before reading the EEPROM again
  delay(1000);
}
