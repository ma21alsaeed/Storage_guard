#include "dht_sensor.h"

DhtSensor::DhtSensor(int pin, int type) : dht_(pin, type) {
  dht_.begin();
}

float DhtSensor::readTemperature() {
  return dht_.readTemperature();
}

float DhtSensor::readHumidity() {
  return dht_.readHumidity();
}