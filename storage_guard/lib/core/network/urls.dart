const baseUrl = 'http://192.168.1.103:8000/api/v1';
const loginUrl = '$baseUrl/login';
const registerUrl = '$baseUrl/user';
const usersUrl = '${baseUrl}api/users';
const operationsUrl='$baseUrl/user/operations';
String operationSensorRecordingsUrl(int operationId) => '$baseUrl/operation-sensor-records/$operationId';
