import 'dart:convert';
import '../constant/network.dart';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class AuthService {
  static Future<dynamic> createUser(User user) async {
    http.Response response = await http.post(Uri.parse(registerEndPoint),
        body: jsonEncode(user.toJson()),
        headers: {'content-type': 'application/json'});
    if (response.statusCode == 200) {
      print("Success");
      return "";
    } else {
      throw ("Some Error Happened");
    }
  }

  static Future<dynamic> loginUser(String email, String password) async {
    http.Response response = await http.post(Uri.parse(logInEndPoint),
        body: jsonEncode({"email": email, "password": password}),
        headers: {'content-type': 'application/json'});
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body)["user"]);
    } else {
      throw ("Some Error Happened");
    }
  }
}
