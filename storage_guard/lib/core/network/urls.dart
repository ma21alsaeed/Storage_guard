const baseUrl = 'http://192.168.1.7:8000/api/v1';
const loginUrl = '$baseUrl/login';
const registerUrl = '$baseUrl/user';
const usersUrl = '${baseUrl}api/users';
String productUrl(int productId) => '$baseUrl/products/$productId';
const operationsUrl = '$baseUrl/user/operations';
String operationSensorRecordingsUrl(int operationId) =>
    '$baseUrl/operation-sensor-records/$operationId';
