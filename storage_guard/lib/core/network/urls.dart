const baseUrl = 'http://192.168.1.104:8000/api/v1';
const loginUrl = '$baseUrl/login';
const registerUrl = '$baseUrl/user';
const usersUrl = '${baseUrl}api/users';
const requestsUrl = '${baseUrl}api/requests';
const operationSensorRecodringsUrl = '${baseUrl}/operation-sensor-records/4';
String updateUserUrl(int id) => '$usersUrl/$id';
String requestUrl(int id) => '$requestsUrl/$id';
