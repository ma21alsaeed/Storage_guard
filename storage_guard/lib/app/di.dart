import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';
import 'package:storage_guard/features/authentication/data/auth_datasource.dart';
import 'package:storage_guard/features/authentication/data/auth_repositories.dart';
import 'package:storage_guard/features/authentication/presentation/cubit/auth_cubit.dart';

abstract class DI {
  static GetIt get di => GetIt.instance;

  static Future<void> init() async {
    final preferences = await SharedPreferences.getInstance();
    // di.registerLazySingleton<UserService>(() => UserService(preferences));
    di.registerLazySingleton<Client>(() => Client());
    registerAuth();
  }

  static void registerAuth() async {
    di.registerLazySingleton<AuthDataSource>(
        () => AuthDataSource(di<Client>()));
    di.registerLazySingleton<AuthRepositories>(
        () => AuthRepositories(di<AuthDataSource>()));
    di.registerFactory<AuthCubit>(() => AuthCubit(di<AuthRepositories>()));
  }
  // static UserService get userService => di.get<UserService>();
  static AuthCubit authCubitFactory() => di.get<AuthCubit>();
}
