part of 'create_operation_cubit.dart';

abstract class CreateOperationState {
  const CreateOperationState();
}

class CreateOperationInitial extends CreateOperationState {}

class LoadingState extends CreateOperationState {}

class CreatedOperationState extends CreateOperationState {
  final OperationModel operation;

  CreatedOperationState(this.operation);
}

class ErrorState extends CreateOperationState {
  final String message;

  ErrorState(this.message);
}
