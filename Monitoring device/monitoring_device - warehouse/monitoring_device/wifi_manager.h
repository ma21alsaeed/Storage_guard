#ifndef WIFI_MANAGER_H
#define WIFI_MANAGER_H

#include <WiFi.h>

class WifiManager {
public:
  WifiManager(const char* ssid, const char* password);
  void connect();
  void disconnect();
  bool isConnected();

private:
  const char* _ssid;
  const char* _password;
};

#endif