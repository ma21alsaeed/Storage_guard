import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:storage_guard/app/di.dart';
import 'package:storage_guard/features/authentication/presentation/login_page.dart';
import 'package:storage_guard/features/transport/services/transport_page_service.dart';
import 'package:storage_guard/features/warehouse/services/warehouse_page_service.dart';
import 'package:storage_guard/features/welcome/welcome_page.dart';
import 'package:storage_guard/main_page.dart';
import 'package:intl/date_symbol_data_local.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class StorageGuardApp extends StatelessWidget {
  static Future<void> init() async {
    //splash screen
    FlutterNativeSplash.preserve(
        widgetsBinding: WidgetsFlutterBinding.ensureInitialized());
    await initLocalization();
    await DI.init();
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    Future.delayed(
      const Duration(milliseconds: 500),
      () => FlutterNativeSplash.remove(),
    );
  }

  static Future<void> initLocalization() async {
    WidgetsFlutterBinding.ensureInitialized();
    // await EasyLocalization.ensureInitialized();
    initializeDateFormatting();
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
          BlocProvider(create: (_) => DI.createClonedProductCubitFactory()),
          BlocProvider(create: (_) => DI.shopCubitFactory()),
          BlocProvider(create: (_) => DI.sendRecordsCubitFactory()),
          BlocProvider(create: (_) => DI.getOperationCubitFactory()),
          BlocProvider(
              create: (_) =>
                  DI.getAllOperationsCubitFactory()..getAllOperations()),
          BlocProvider(create: (_) => DI.createOperationCubitFactory()),
        ],
        child: MaterialApp(
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            navigatorKey: navigatorKey,
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
