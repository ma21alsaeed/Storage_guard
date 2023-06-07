#include "sensor_data.h"

SensorDataManager::SensorDataManager() : data_index_(0) {
  EEPROM.begin(EEPROM_SIZE * MAX_DATA_POINTS);
}

void SensorDataManager::writeSensorDataToEEPROM(int index, SensorData data) {
  int addr = index * EEPROM_SIZE;
  byte* dataPtr = (byte*) &data;
  for (int i = 0; i < EEPROM_SIZE; i++) {
    EEPROM.write(addr + i, *(dataPtr + i));
	EEPROM.commit();
  }
}

SensorData SensorDataManager::readSensorDataFromEEPROM(int index) {
  int addr = index * EEPROM_SIZE;
  SensorData data;
  byte* dataPtr = (byte*) &data;
  for (int i = 0; i < EEPROM_SIZE; i++) {
    *(dataPtr + i) = EEPROM.read(addr + i);
  }
  return data;
}

void SensorDataManager::addDataPointToEEPROM(float temperature, float humidity, int state, unsigned long timestamp) {
  if (EEPROM_START_ADDR + (data_index_ + 1) * EEPROM_SIZE <= EEPROM.length()) {
    SensorData data = { temperature, humidity, state, timestamp };
	
    writeSensorDataToEEPROM(data_index_, data);
    data_index_++;
  }
}

std::vector<SensorData> SensorDataManager::readAllDataPointsFromEEPROM() {
  std::vector<SensorData> data_points;
  for (int i = 0; i < data_index_; i++) {
    SensorData data = readSensorDataFromEEPROM(i);
    data_points.push_back(data);
  }
  return data_points;
}

void SensorDataManager::clearAllDataPointsFromEEPROM() {
  for (int i = 0; i < MAX_DATA_POINTS; i++) {
    SensorData data = { 0 };
    writeSensorDataToEEPROM(i, data);
  }
  data_index_ = 0;
}