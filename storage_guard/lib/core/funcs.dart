

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
