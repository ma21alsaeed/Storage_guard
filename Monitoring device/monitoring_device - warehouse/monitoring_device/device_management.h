#ifndef DEVICE_MANAGEMENT_H
#define DEVICE_MANAGEMENT_H

#include <ArduinoJson.h>
#include <ESP32Time.h>
#include "dht_sensor.h"
#include "bluetooth_connection.h"
#include "files_management.h"
#include "oled.h"
#include "api_services.h"

class DeviceManagement{

    public:
    DeviceManagement();
    void begin();
    void printAllFiles(fs::FS &fs);
    void resetDeivce(fs::FS &fs);
    bool readSensorData();
    bool resendSensorData(fs::FS &fs);
    void storeSensorData(fs::FS &fs,bool wasSent);
    void showSensorData();
    bool sendSensorData();
    void reciveOperationInfo();


    private:
    DhtSensor dhtSensor;
    BluetoothConnection bluetoothConnection;
    ApiServices apiServices;
    OLED oled;
    ESP32Time rtc;
};

#endif
