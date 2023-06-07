#ifndef DHT_SENSOR_H
#define DHT_SENSOR_H

#include <DHT.h>

class DhtSensor {
  public:
    DhtSensor(int pin, int type);
    float readTemperature();
    float readHumidity();
  private:
    DHT dht_;
};

#endif