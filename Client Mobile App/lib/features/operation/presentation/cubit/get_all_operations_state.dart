part of 'get_all_operations_cubit.dart';

abstract class GetAllOperationsState {
  const GetAllOperationsState();
}

class GetAllOperationsInitial extends GetAllOperationsState {}

class LoadingState extends GetAllOperationsState {}

class GotOperationsState extends GetAllOperationsState {
  final List<OperationModel> operations;

  GotOperationsState(this.operations);
}

class ErrorState extends GetAllOperationsState {
  final String message;

  ErrorState(this.message);
}
