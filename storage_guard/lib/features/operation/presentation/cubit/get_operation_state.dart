part of 'get_operation_cubit.dart';

abstract class GetOperationState {
  const GetOperationState();
}

class GetOperationInitial extends GetOperationState {}

class LoadingState extends GetOperationState {}

class GotOperationState extends GetOperationState {
  final OperationModel operation;

  GotOperationState(this.operation);
}

class ErrorState extends GetOperationState {
  final String message;

  ErrorState(this.message);
}
