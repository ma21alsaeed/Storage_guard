#ifndef API_SERVICES_H
#define API_SERVICES_H
#include <ArduinoJson.h>
#include <HTTPClient.h>
class ApiServices {

public:
  ApiServices(const char* baseEndPoint);
  void setReferenceTime(String referenceTime);
  void setToken(String token);
  void setOperationId(int operationId);
  bool addSensorData(float temperature, float humidity, String datetime);

private:

  String _token;
  int _operationId;
  const char* _baseEndPoint;

};

#endif
