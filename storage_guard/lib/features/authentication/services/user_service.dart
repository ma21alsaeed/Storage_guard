// import 'dart:convert';

// import 'package:shared_preferences/shared_preferences.dart';

// class UserService {
//   final SharedPreferences _preferences;
//   UserService(this._preferences);
//   static const String user_key = "user";

//   Future setUser(UserModel user) async {
//     Map userJson = user.toJson();
//     _preferences.setString(user_key, jsonEncode(userJson));
//   }

//   UserModel? getUser() {
//     String? userString = _preferences.getString(user_key);
//     return userString != null ? userModelFromJson(userString) : null;
//   }
// }
