part of 'auth_cubit.dart';

abstract class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {}

class LoadingState extends AuthState {}

class AuthenticatedState extends AuthState {
  final UserModel user;

  AuthenticatedState(this.user);
}
class RegisteredState extends AuthState {
  final UserModel user;

  RegisteredState(this.user);
}
class ErrorState extends AuthState {
  final String message;

  ErrorState(this.message);
}
