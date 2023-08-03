import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';
import 'package:storage_guard/app/bluetooth.dart';
import 'package:storage_guard/features/authentication/data/auth_datasource.dart';
import 'package:storage_guard/features/authentication/data/auth_repositories.dart';
import 'package:storage_guard/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:storage_guard/features/authentication/services/user_service.dart';
import 'package:storage_guard/features/operation/data/operation_datasource.dart';
import 'package:storage_guard/features/operation/data/operation_repositories.dart';
import 'package:storage_guard/features/operation/presentation/cubit/create_operation_cubit.dart';
import 'package:storage_guard/features/operation/presentation/cubit/get_all_operations_cubit.dart';
import 'package:storage_guard/features/operation/presentation/cubit/send_records_cubit.dart';
import 'package:storage_guard/features/product/data/product_datasource.dart';
import 'package:storage_guard/features/product/data/product_repositories.dart';
import 'package:storage_guard/features/product/presentation/cubit/product_cubit.dart';
import 'package:storage_guard/features/shop/data/shop_datasource.dart';
import 'package:storage_guard/features/shop/data/shop_repositories.dart';
import 'package:storage_guard/features/shop/presentation/cubit/shop_cubit.dart';
import 'package:storage_guard/features/welcome/services/welcome_service.dart';

abstract class DI {
  static GetIt get di => GetIt.instance;

  static Future<void> init() async {
    final preferences = await SharedPreferences.getInstance();
    di.registerLazySingleton<WelcomeService>(() => WelcomeService(preferences));
    di.registerLazySingleton<UserService>(() => UserService(preferences));
    di.registerLazySingleton<Client>(() => Client());
    di.registerLazySingleton<BluetoothService>(
        () => BluetoothService(preferences, di<OperationRepositories>()));
    registerAuth();
    registerProduct();
    registerShop();
    registerOperation(preferences);
  }

  static void registerAuth() async {
    di.registerLazySingleton<AuthDataSource>(
        () => AuthDataSource(di<Client>()));
    di.registerLazySingleton<AuthRepositories>(
        () => AuthRepositories(di<AuthDataSource>()));
    di.registerFactory<AuthCubit>(() => AuthCubit(di<AuthRepositories>()));
  }

  static void registerProduct() async {
    di.registerLazySingleton<ProductDataSource>(
        () => ProductDataSource(di<Client>()));
    di.registerLazySingleton<ProductRepositories>(
        () => ProductRepositories(di<ProductDataSource>()));
    di.registerFactory<ProductCubit>(
        () => ProductCubit(di<ProductRepositories>()));
  }

  static void registerShop() async {
    di.registerLazySingleton<ShopDataSource>(
        () => ShopDataSource(di<Client>()));
    di.registerLazySingleton<ShopRepositories>(
        () => ShopRepositories(di<ShopDataSource>()));
    di.registerFactory<ShopCubit>(() => ShopCubit(di<ShopRepositories>()));
  }

  static void registerOperation(SharedPreferences preferences) async {
    di.registerLazySingleton<OperationDataSource>(
        () => OperationDataSource(di<Client>()));
    di.registerLazySingleton<OperationRepositories>(
        () => OperationRepositories(di<OperationDataSource>()));
    di.registerFactory<SendRecordsCubit>(
        () => SendRecordsCubit(di<OperationRepositories>(), preferences));
    di.registerFactory<GetAllOperationsCubit>(
        () => GetAllOperationsCubit(di<OperationRepositories>()));
    di.registerFactory<CreateOperationCubit>(
        () => CreateOperationCubit(di<OperationRepositories>()));
  }

  static UserService get userService => di.get<UserService>();
  static WelcomeService get welcomeService => di.get<WelcomeService>();
  static BluetoothService get bluetoothService => di.get<BluetoothService>();
  static AuthCubit authCubitFactory() => di.get<AuthCubit>();
  static ProductCubit productCubitFactory() => di.get<ProductCubit>();
  static ShopCubit shopCubitFactory() => di.get<ShopCubit>();
  static SendRecordsCubit sendRecordsCubitFactory() =>
      di.get<SendRecordsCubit>();
  static GetAllOperationsCubit getAllOperationsCubitFactory() =>
      di.get<GetAllOperationsCubit>();
  static CreateOperationCubit createOperationCubitFactory() =>
      di.get<CreateOperationCubit>();
}
