#ifndef DEVICE_MANAGEMENT_H
#define DEVICE_MANAGEMENT_H

#include <ArduinoJson.h>
#include "dht_sensor.h"
#include "bluetooth_connection.h"
#include "files_management.h"
#include "oled.h"

class DeviceManagement{

    public:
    DeviceManagement();
    void begin();
    void printAllFiles(fs::FS &fs);
    void resetDeivce(fs::FS &fs);
    bool readSensorData();
    bool resendSensorData(fs::FS &fs,bool firstTime);

    void storeSensorData(fs::FS &fs,bool wasSent);
    void showSensorData();
    bool sendSensorData(bool firstTime);


    private:
    DhtSensor dhtSensor;
    BluetoothConnection bluetoothConnection;
    OLED oled;
};

#endif
