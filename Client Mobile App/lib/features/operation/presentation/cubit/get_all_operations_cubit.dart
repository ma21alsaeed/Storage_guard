import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storage_guard/core/funcs.dart';
import 'package:storage_guard/features/operation/data/operation_model.dart';
import 'package:storage_guard/features/operation/data/operation_repositories.dart';

part 'get_all_operations_state.dart';

class GetAllOperationsCubit extends Cubit<GetAllOperationsState> {
  final OperationRepositories _operationRepositories;
  GetAllOperationsCubit(this._operationRepositories)
      : super(GetAllOperationsInitial());

  Future<void> getAllOperations() async {
    emit(LoadingState());
    final either = await _operationRepositories.getAllOperations();
    either.fold((error) async {
      final errorMessage = getErrorMessage(error);
      emit(ErrorState(errorMessage));
    }, (data) {
      emit(GotOperationsState(data));
    });
  }
}
