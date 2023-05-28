const baseUrl = 'http://192.168.1.101:1337/';
const loginUrl = '${baseUrl}api/auth/local';
const registerUrl = '$loginUrl/register';
const usersUrl = '${baseUrl}api/users';
const requestsUrl = '${baseUrl}api/requests';
String updateUserUrl(int id) => '$usersUrl/$id';
String requestUrl(int id) => '$requestsUrl/$id';
