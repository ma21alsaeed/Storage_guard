#ifndef BLUETOOTH_CONNECTION_H
#define BLUETOOTH_CONNECTION_H

#include "BluetoothSerial.h"

class BluetoothConnection
{

  public:
  BluetoothConnection(String name);
  void start();
  bool isConnected();
  String receiveData();
  void closeConnection();
  bool sendData(const String& data);

  private:
  BluetoothSerial SerialBT_;
  String _name;
};
#endif
