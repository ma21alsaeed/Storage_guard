import 'package:dartz/dartz.dart';
import 'package:storage_guard/core/error/failures.dart';
import 'package:storage_guard/core/network/repositories.dart';
import 'package:storage_guard/features/operation/data/operation_datasource.dart';
import 'package:storage_guard/features/operation/data/operation_model.dart';

class OperationRepositories {
  final OperationDataSource _operationDataSource;
  OperationRepositories(this._operationDataSource);

  Future<Either<Failure, void>> sendSensorRecordings(
          List<Map<String, dynamic>> data,int operationId) async =>
      await repository(
          () async => await _operationDataSource.sendSensorRecordings(data,operationId));

  Future<Either<Failure, OperationModel>> createOperation(
          Map<String, dynamic> data) async =>
      await repository(
          () async => await _operationDataSource.createOperation(data));

  Future<Either<Failure, List<OperationModel>>> getAllOperations() async =>
      await repository(
          () async => await _operationDataSource.getAllOperations());
}
