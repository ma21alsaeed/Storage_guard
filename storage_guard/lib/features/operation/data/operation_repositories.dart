import 'package:dartz/dartz.dart';
import 'package:storage_guard/core/error/failures.dart';
import 'package:storage_guard/core/network/repositories.dart';
import 'package:storage_guard/features/operation/data/operation_datasource.dart';

class OperationRepositories {
  final OperationDataSource _operationDataSource;
  OperationRepositories(this._operationDataSource);
  
  Future<Either<Failure, void>> sendSensorRecordings(Map<String, dynamic> data) async =>
      await repository(() async => await _operationDataSource.sendSensorRecordings(data));

}
