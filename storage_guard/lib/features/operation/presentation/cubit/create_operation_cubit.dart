import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storage_guard/core/funcs.dart';
import 'package:storage_guard/features/operation/data/operation_model.dart';
import 'package:storage_guard/features/operation/data/operation_repositories.dart';

part 'create_operation_state.dart';

class CreateOperationCubit extends Cubit<CreateOperationState> {
  final OperationRepositories _operationRepositories;
  CreateOperationCubit(this._operationRepositories)
      : super(CreateOperationInitial());

  Future<void> createOperation(Map<String, dynamic> data) async {
    emit(LoadingState());
    final either = await _operationRepositories.createOperation(data);
    either.fold((error) async {
      final errorMessage = getErrorMessage(error);
      emit(ErrorState(errorMessage));
    }, (data) {
      emit(CreatedOperationState(data));
    });
  }
}
