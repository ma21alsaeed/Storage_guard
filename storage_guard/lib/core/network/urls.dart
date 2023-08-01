const baseUrl = 'http://192.168.1.49:8000/api/v1';
const loginUrl = '$baseUrl/login';
const registerUrl = '$baseUrl/user';
const usersUrl = '${baseUrl}api/users';
const requestsUrl = '${baseUrl}api/requests';
const operationSensorRecodringsUrl = '$baseUrl/operation-sensor-records/1';
String updateUserUrl(int id) => '$usersUrl/$id';
String requestUrl(int id) => '$requestsUrl/$id';
