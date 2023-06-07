#ifndef SENSOR_DATA_H
#define SENSOR_DATA_H

#include <EEPROM.h>

const int EEPROM_SIZE = 10;
const int MAX_DATA_POINTS = 100;
const int EEPROM_START_ADDR = 0;

struct SensorData {
  float temperature;
  float humidity;
  int state;
  int  unsigned long timestamp;
};

class SensorDataManager {
  public:
    SensorDataManager();
    void addDataPointToEEPROM(float temperature, float humidity, int state, unsigned long timestamp);
    std::vector<SensorData> readAllDataPointsFromEEPROM();
    void clearAllDataPointsFromEEPROM();
  private:
    void writeSensorDataToEEPROM(int index, SensorData data);
    SensorData readSensorDataFromEEPROM(int index);
    int data_index_;
};

#endif