#include "device_management.h"

#define DHT_PIN 15
#define DHT_TYPE DHT11

#define DEVICE_NAME "StorageGuard Device"
#define SENSOR_DATA_FILE_PATH "/Data/sensor_data.json"
#define ERROR_LOGS_FILE_PATH "/error_logs.json"
#define DEVICE_CONF_FILE_PATH "/conf.json"


DeviceManagement::DeviceManagement() :
  bluetoothConnection(DEVICE_NAME),
  dhtSensor(DHT_PIN, DHT_TYPE),
  oled()
{
  // Constructor body
}

void DeviceManagement::resetDeivce(fs::FS &fs) {
  deleteFile(fs, SENSOR_DATA_FILE_PATH);
  deleteAllFiles(fs, "/Data", 4);
  removeDir(fs, "/Data");
  createDir(fs, "/Data");
}

bool DeviceManagement::resendSensorData(fs::FS &fs,bool firstTime) {
  String data = "";
  // Open the file for reading
  File file = fs.open(SENSOR_DATA_FILE_PATH, FILE_READ);
  if (!file) {
    Serial.println("Failed to open file for reading");
    return false;
  }

  // Create a temporary string to store the updated file content
  String updatedFileContent = "";

  // Read each line of the file and print lines with wasSent=true
  while (file.available()) {
    // Read the next line of the file
    String line = file.readStringUntil('\n');

    // Parse the line into a JSON document
    StaticJsonDocument<256> jsonDoc;
    DeserializationError error = deserializeJson(jsonDoc, line);
    if (error) {
      Serial.print("Failed to parse line: ");
      Serial.println(line);
      continue;
    }
      if (firstTime) {
    //send max runtime
    data = String(millis());
    if (bluetoothConnection.sendData(data)) {
      return true;
    }
    else {
      return false;
    }
  }

    // Check if wasSent is true and print the line
    if (jsonDoc["wasSent"] == false) {
      float humidity = jsonDoc["temp"];
      float temperature = jsonDoc["hum"];
      long timestamp = jsonDoc["timestamp"];
       data = String(temperature) + "," + String(humidity) + "," + String(timestamp);
      if (bluetoothConnection.sendData(data)) {
        jsonDoc["wasSent"] = true;
      }
      else {
        jsonDoc["wasSent"] = false;
      }
    }

    // Serialize the updated JSON document and append it to the updated file content
    String updatedLine;
    serializeJson(jsonDoc, updatedLine);
    updatedFileContent += updatedLine + "\n";
  }

  // Close the file
  file.close();

  // Open the file for writing
  File fileForWriting = fs.open(SENSOR_DATA_FILE_PATH, FILE_WRITE);
  if (!fileForWriting) {
    Serial.println("Failed to open file for writing");
    return false;
  }

  // Write the updated file content to the file
  fileForWriting.print(updatedFileContent);

  // Close the file
  fileForWriting.close();

  return true;
}





void DeviceManagement::printAllFiles(fs::FS &fs) {
  Serial.print("hello");
  listDir(fs, "/", 3);
}
void DeviceManagement::begin() {
  bluetoothConnection.start();
  oled.begin();
  oled.splashScreen();
  oled.displayLoadingAnimation();
  delay(100);

}

bool DeviceManagement::readSensorData() {
  if (dhtSensor.readValues()) {
    return true;
  }
  else {
    return false;
  }
}


void DeviceManagement::storeSensorData(fs::FS &fs , bool wasSent) {
  appendSensorData(fs, SENSOR_DATA_FILE_PATH, dhtSensor.getTemperature(), dhtSensor.getHumidity(), wasSent);

}
void DeviceManagement::showSensorData() {
  oled.showTempAndHum(dhtSensor.getTemperature(), dhtSensor.getHumidity(), bluetoothConnection.isConnected());
}
bool DeviceManagement::sendSensorData(bool firstTime) {
  String data = "";
  float humidity = dhtSensor.getTemperature();
  float temperature = dhtSensor.getHumidity();
  if (firstTime) {
    //send max runtime
    data = String(millis());
    if (bluetoothConnection.sendData(data)) {
      return true;
    }
    else {
      return false;
    }
  }
  
    data = String(temperature) + "," + String(humidity) + "," + String(millis());
    if ( bluetoothConnection.sendData(data))
    {
      return true;
    }
    else {
      return false;
    }

  
}

/*void DeviceManagement::writeError(String source ,String error){
  StaticJsonDocument<64> jsonDoc;
  String jsonString;
  jsonDoc["source"] = source
  jsonDoc["error"] = error
  jsonDoc["timestamp"] = millis();
  serializeJson(jsonDoc, jsonString);
  appendSensorData(fs, ERROR_LOGS_FILE_PATH, jsonString);
  }*/
