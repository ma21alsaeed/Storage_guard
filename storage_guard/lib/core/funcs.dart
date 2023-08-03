import 'package:storage_guard/core/error/failures.dart';

String getErrorMessage(Failure error) {
  if (error is ServerFailure) {
    return 'Server Error Please Try Again Later';
  } else if (error is HttpFailure) {
    return error.message;
  } else {
    return 'Unknown Error Please Try Again Later';
  }
}

String getTextFieldValidationInfo(String email, String password,
    {bool isSignUp = false,
    String? userName,
    String? confirmPass,
    String? phone}) {
  String message = "";
  if (email.isEmpty) {
    message = "Email should Not Be Empty";
  }
  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email) &&
        email.isNotEmpty) {
      message = "$message\nInvalid email address format";
    }
  if (password.isEmpty) {
    message = "$message\nPassword should Not Be Empty";
  }
  if (password.length < 6 && password.isNotEmpty) {
    message = "$message\nPassword should not be less than 6 characters";
  }
  if (isSignUp) {
    if (confirmPass != password) {
      message = "$message\nPasswords do not match";
    }
    if (userName!.isEmpty) {
      message = "$message\nUsername should not be empty";
    }
    if (phone!.isEmpty) {
      message = "$message\nPhone should not be empty";
    }
    if (!RegExp(r'^((\+|00)?9639|0?9)([3-6]|[8,9])\d{7}$').hasMatch(phone) &&
        phone.isNotEmpty) {
      message = "$message\nPlease enter a syrian phone number";
    }
  }
  return message.trim();
}