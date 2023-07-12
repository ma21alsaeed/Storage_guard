#include "bluetooth_connection.h"
BluetoothConnection::BluetoothConnection(String name): SerialBT_(){
   _name = name;
  }
void BluetoothConnection::start(){
  SerialBT_.begin(_name);
  }

bool BluetoothConnection::isConnected() {
  return SerialBT_.connected();
}

bool BluetoothConnection::sendData(const String& data) {
  if (isConnected()) {
    SerialBT_.println(data);
    return true;
  } else {
    Serial.println("Please check connection");
    return false;
  }
}

String BluetoothConnection::receiveData() {
  if (isConnected() && SerialBT_.available()) {
    return SerialBT_.readString();
  } else {
    return "Please check connection";
  }
}

void BluetoothConnection::closeConnection() {
  if (isConnected()) {
    SerialBT_.end();
  } else {
    Serial.println("Connection is not open");
  }
}
