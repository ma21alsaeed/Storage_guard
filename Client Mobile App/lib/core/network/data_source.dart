import 'dart:convert';

import 'package:storage_guard/app/di.dart';
import 'package:storage_guard/core/error/excpetions.dart';

Future<T> dataSource<T>(Function call,
    {Function? model, bool isUpdateUser = false}) async {
  final response = await call();
  print("responseIs: ${response.body}");
  var jsonResponse = json.decode(response.body);
  if (jsonResponse["message"] == "Unauthenticated.") {
    await DI.userService.logout();
  }
  if (response.statusCode == 200) {
    if (model == null) {
      return Future.value(null);
    }
    return model(response.body);
  } else {
    throw jsonResponse["message"] == null
        ? HttpException(jsonResponse["error"])
        : HttpException(jsonResponse["message"]);
  }
}
