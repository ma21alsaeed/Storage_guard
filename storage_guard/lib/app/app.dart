import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:storage_guard/app/di.dart';
import 'package:storage_guard/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:storage_guard/features/authentication/presentation/login_page.dart';
import 'package:storage_guard/features/operation/presentation/cubit/create_operation_cubit.dart';
import 'package:storage_guard/features/operation/presentation/cubit/get_all_operations_cubit.dart';
import 'package:storage_guard/features/operation/presentation/cubit/send_records_cubit.dart';
import 'package:storage_guard/features/product/presentation/cubit/product_cubit.dart';
import 'package:storage_guard/features/shop/presentation/cubit/shop_cubit.dart';
import 'package:storage_guard/features/transport/services/transport_page_service.dart';
import 'package:storage_guard/features/warehouse/services/warehouse_page_service.dart';
import 'package:storage_guard/features/welcome/welcome_page.dart';
import 'package:storage_guard/main_page.dart';

class StorageGuardApp extends StatelessWidget {
  static Future<void> init() async {
    //splash screen
    FlutterNativeSplash.preserve(
        widgetsBinding: WidgetsFlutterBinding.ensureInitialized());
    await DI.init();
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    Future.delayed(
      const Duration(milliseconds: 500),
      () => FlutterNativeSplash.remove(),
    );
  }

  const StorageGuardApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TransportPageService(),
        ),
        ChangeNotifierProvider(
          create: (_) => WarehousePageService(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => DI.authCubitFactory()),
          BlocProvider(create: (_) => DI.productCubitFactory()),
          BlocProvider(create: (_) => DI.shopCubitFactory()),
          BlocProvider(create: (_) => DI.sendRecordsCubitFactory()),
          BlocProvider(
              create: (_) =>
                  DI.getAllOperationsCubitFactory()..getAllOperations()),
          BlocProvider(create: (_) => DI.createOperationCubitFactory()),
        ],
        child: MaterialApp(
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            // home: const MainPage()
            home: DI.userService.getUser() == null
                ? const LoginPage()
                : DI.welcomeService.getIsFirstTime() != null
                    ? const MainPage()
                    : const WelcomePage()),
      ),
    );
  }
}
