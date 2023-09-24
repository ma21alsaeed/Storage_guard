import 'package:dartz/dartz.dart';
import 'package:storage_guard/core/error/excpetions.dart';
import 'package:storage_guard/core/error/failures.dart';

Future<Either<Failure, T>> repository<T>(
    Function call) async {
    try {
      final T result = await call();
      return Right(result);
    } on HttpException catch (e) {
      return Left(HttpFailure(e.message));
    } on Exception {
      return Left(ServerFailure());
    }
}