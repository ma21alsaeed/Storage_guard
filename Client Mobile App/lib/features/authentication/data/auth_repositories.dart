import 'package:dartz/dartz.dart';
import 'package:storage_guard/core/error/failures.dart';
import 'package:storage_guard/core/network/repositories.dart';
import 'package:storage_guard/features/authentication/data/auth_datasource.dart';
import 'package:storage_guard/features/authentication/data/user_model.dart';

class AuthRepositories {
  final AuthDataSource _authDataSource;
  AuthRepositories(this._authDataSource);
  
  Future<Either<Failure, UserModel>> login(Map<String, dynamic> data) async =>
      await repository(() async => await _authDataSource.login(data));

  Future<Either<Failure, UserModel>> register(Map<String, dynamic> data) async =>
      await repository(() async => await _authDataSource.register(data));
}
