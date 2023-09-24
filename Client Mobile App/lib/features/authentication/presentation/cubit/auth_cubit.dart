import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storage_guard/app/di.dart';
import 'package:storage_guard/core/funcs.dart';
import 'package:storage_guard/features/authentication/data/auth_repositories.dart';
import 'package:storage_guard/features/authentication/data/user_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepositories _authRepositories;
  AuthCubit(this._authRepositories) : super(AuthInitial());
  Future<void> login(Map<String, dynamic> data) async {
    print(data);
    emit(LoadingState());
    final either = await _authRepositories.login(data);
    either.fold((error) async {
      final errorMessage = getErrorMessage(error);
      emit(ErrorState(errorMessage));
    }, (data) {
      DI.userService.setUser(data);
      emit(AuthenticatedState(data));
    });
  }

  Future<void> register(Map<String, dynamic> data) async {
    emit(LoadingState());
    final either = await _authRepositories.register(data);
    either.fold((error) async {
      final errorMessage = getErrorMessage(error);
      emit(ErrorState(errorMessage));
    }, (data) {
      emit(RegisteredState(data));
    });
  }
}
