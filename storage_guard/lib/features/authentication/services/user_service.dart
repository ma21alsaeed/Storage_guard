import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storage_guard/app/app.dart';
import 'package:storage_guard/features/authentication/data/user_model.dart';
import 'package:storage_guard/features/authentication/presentation/login_page.dart';

class UserService {
  final SharedPreferences _preferences;
  UserService(this._preferences);
  static const String user_key = "user";

  Future setUser(UserModel user) async {
    Map userJson = user.toJson();
    _preferences.setString(user_key, jsonEncode(userJson));
  }

  UserModel? getUser() {
    String? userString = _preferences.getString(user_key);
    return userString != null ? userModelFromJson(userString) : null;
  }

  Future<void> logout() async =>
      await _preferences.remove(user_key).then((value) {
        if (value) {
          navigatorKey.currentState!.pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const LoginPage()),
              (route) => route.isFirst);
        } else {
          Fluttertoast.showToast(msg: "Unable to logout");
        }
      });
}
