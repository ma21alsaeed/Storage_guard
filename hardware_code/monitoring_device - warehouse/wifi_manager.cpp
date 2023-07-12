#include "wifi_manager.h"

WifiManager::WifiManager(const char* ssid, const char* password) {
  _ssid = ssid;
  _password = password;
}

void WifiManager::connect() {
  WiFi.begin(_ssid, _password);
  Serial.print("Connecting to WiFi...");
  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.print(".");
  }
  Serial.println("Connected to WiFi");
}

void WifiManager::disconnect() {
  WiFi.disconnect();
}

bool WifiManager::isConnected() {
  return WiFi.status() == WL_CONNECTED;
}