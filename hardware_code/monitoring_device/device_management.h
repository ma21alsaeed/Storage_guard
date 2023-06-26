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
    bool readSensorData();
    void storeSensorData(fs::FS &fs);
    void showSensorData();
    void sendSensorData();


    private:
    DhtSensor dhtSensor;
    BluetoothConnection bluetoothConnection;
    OLED oled;
};

#endif
