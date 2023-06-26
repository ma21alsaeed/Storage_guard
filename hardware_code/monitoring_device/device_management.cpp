#include "device_management.h"

#define DHT_PIN 15
#define DHT_TYPE DHT11
#define DEVICE_NAME "StorageGuard Device"
#define SENSOR_DATA_FILE_PATH "/Data/sensor_data.json"
#define DEVICE_CONF_FILE_PATH "/conf.json"

DeviceManagement::DeviceManagement() :
  bluetoothConnection(DEVICE_NAME),
  dhtSensor(DHT_PIN, DHT_TYPE),
  oled()
{
  // Constructor body
}

void DeviceManagement::begin(){
    bluetoothConnection.start();
    oled.begin();
    
}

bool DeviceManagement::readSensorData(){
    if(dhtSensor.readValues()){
        return true;
    }
    else{
        return false;
    }}


void DeviceManagement::storeSensorData(fs::FS &fs){
  StaticJsonDocument<64> jsonDoc;
  String jsonString;
  jsonDoc["temperature"] = dhtSensor.getTemperature();
  jsonDoc["humidity"] = dhtSensor.getHumidity();
  jsonDoc["timestamp"] = millis();
  jsonDoc["wasSent"]  = false;
  
  serializeJson(jsonDoc, jsonString);
  appendSensorData(fs, SENSOR_DATA_FILE_PATH, jsonString);
  
}
void DeviceManagement::showSensorData(){
    oled.showTempAndHum(dhtSensor.getTemperature(),dhtSensor.getHumidity());
}
void DeviceManagement::sendSensorData(){
    float humidity = dhtSensor.getTemperature();
    float temperature = dhtSensor.getHumidity();
    String data = String(temperature) + "," + String(humidity);
    bluetoothConnection.sendData(data);

}    
    
