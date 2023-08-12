import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storage_guard/core/funcs.dart';
import 'package:storage_guard/features/operation/data/operation_model.dart';
import 'package:storage_guard/features/operation/data/operation_repositories.dart';

part 'get_operation_state.dart';

class GetOperationCubit extends Cubit<GetOperationState> {
  final OperationRepositories _operationRepositories;
  GetOperationCubit(this._operationRepositories)
      : super(GetOperationInitial());

  Future<void> getOperation(int operationId) async {
    emit(LoadingState());
    final either = await _operationRepositories.getOperation(operationId);
    either.fold((error) async {
      final errorMessage = getErrorMessage(error);
      emit(ErrorState(errorMessage));
    }, (data) {
      emit(GotOperationState(data));
    });
  }
}
