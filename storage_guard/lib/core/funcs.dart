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

String getTextFieldValidationInfoLogin(String email, String password) {
  if (password.isNotEmpty) {
    if (email.isNotEmpty) {
      if (password.length < 6) {
        return "Password Should not be less than 6 characters";
      }
      return '';
    } else {
      if (password.length < 6) {
        return "Email should not be empty\nPassword should not be less than 6 characters";
      }
      return "Email should Not Be Empty";
    }
  } else {
    if (email.isEmpty) {
      return 'Email/Password fields should not be empty';
    }
    return "Password should not be empty";
  }
  //  if (email.isEmpty || password.isEmpty) {
  //   return 'Email/Password fields should not be empty';
  // } else if (password.length < 6) {
  //   return 'Password should not be less than 6 characters';
  // }
  // return '';
}

String getTextFieldValidationInfoSignUp(
    String userName, String email, String password, String confirmPass) {
  if (confirmPass == password && userName.isNotEmpty) {
    return getTextFieldValidationInfoLogin(email, password);
  } else if (confirmPass != password && userName.isNotEmpty) {
    return "Passwords do not match\n${getTextFieldValidationInfoLogin(email, password)}";
  } else if (confirmPass == password && userName.isEmpty) {
    return "Username should not be empty\n${getTextFieldValidationInfoLogin(email, password)}";
  } else {
    return "Username should not be empty\nPasswords do not match\n${getTextFieldValidationInfoLogin(email, password)}";
  }
}
