const baseUrl = 'http://192.168.139.240:8000/api/v1';
const loginUrl = '$baseUrl/login';
const registerUrl = '$baseUrl/user';
const usersUrl = '${baseUrl}api/users';
const clonedProductsUrl = '$baseUrl/create-cloned-product';
String productUrl(int productId) => '$baseUrl/products/$productId';
const operationsUrl = '$baseUrl/user/operations';
String operationUrl(int operationId) => '$operationsUrl/$operationId';
String operationSensorRecordingsUrl(int operationId) =>
    '$baseUrl/operation-sensor-records/$operationId';
