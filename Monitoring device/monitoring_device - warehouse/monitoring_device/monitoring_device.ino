#include "device_management.h"
#include <WiFi.h>
#include <LITTLEFS.h>
#define FORMAT_LITTLEFS_IF_FAILED true
#define RESTART_BUTTON_PIN 12
#define RESTART_BUTTON_PIN2 13
DeviceManagement deviceManagement = DeviceManagement();
bool checkFile = false;
bool firstTime = true;
void setup() {
Serial.begin(115200);
const char* ssid = "Dell Precision 5530";
const char* password = "12341234";
  WiFi.begin(ssid, password);
  Serial.println("Connecting to WiFi...");
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }

  pinMode(RESTART_BUTTON_PIN,INPUT);
  pinMode(RESTART_BUTTON_PIN2,OUTPUT);
  if (!LITTLEFS.begin(FORMAT_LITTLEFS_IF_FAILED)) {
    Serial.println("LITTLEFS Mount Failed");
    return;
  }
  deviceManagement.begin();
  if (digitalRead(RESTART_BUTTON_PIN)==HIGH) { // Check if Boot button is pressed
    deviceManagement.resetDeivce(LITTLEFS);
    delay(100);
  }
}
void loop() {
if(firstTime){
  deviceManagement.reciveOperationInfo();
  delay(100);
}
else{
 if (digitalRead(RESTART_BUTTON_PIN) == HIGH) { // Check if Boot button is pressed
    deviceManagement.resetDeivce(LITTLEFS);
    delay(100);
  }
  readFile(LITTLEFS,"/Data/sensor_data.json");
  if (checkFile) {
    deviceManagement.resendSensorData(LITTLEFS);
  }
  if (deviceManagement.readSensorData()) {
    deviceManagement.showSensorData();
    if (deviceManagement.sendSensorData())
    {
      deviceManagement.storeSensorData(LITTLEFS, true);
      checkFile = false;
    }
    else {
      deviceManagement.storeSensorData(LITTLEFS, false);
      checkFile = true;
    }
    delay(10000);

  }
}}
