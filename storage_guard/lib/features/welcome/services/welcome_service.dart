import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:storage_guard/features/authentication/data/user_model.dart';

class WelcomeService {
  final SharedPreferences _preferences;
  WelcomeService(this._preferences);
  static const String isFirstTimeKey = "is_first_time_key";

  Future setIsFirstTime() async {
    _preferences.setBool(isFirstTimeKey, true);
  }

  bool? getIsFirstTime() => _preferences.getBool(isFirstTimeKey);
}
