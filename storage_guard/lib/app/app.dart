import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:storage_guard/app/di.dart';
import 'package:storage_guard/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:storage_guard/features/authentication/presentation/login_page.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => DI.di<AuthCubit>()),
      ],
      child: MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home:const WelcomePage()
          //  DI.userService.getUser() == null
          //     ? const LoginPage()
          //     : 
              // DI.welcomeService.getIsFirstTime() != null
              //     ? const MainPage()
              //     : const WelcomePage()
                  ),
    );
    // MultiProvider(
    //   providers: [
    //     ChangeNotifierProvider(
    //       create: (_) => DI.assistant,
    //     ),
    //   ],
    //   child: MultiBlocProvider(
    //     providers: [
    //       BlocProvider(create: (_) => DI.di<AuthCubit>()),
    //       BlocProvider(create: (_) => DI.di<UpdateLocationCubit>()),
    //       BlocProvider(create: (_) => DI.di<GetUsersCubit>()),
    //       BlocProvider(create: (_) => DI.di<RequestHelpCubit>()),
    //       BlocProvider(create: (_) => DI.di<GetRequestCubit>()),
    //     ],
    //     child: MaterialApp(
    //       theme: ThemeData(
    //         primarySwatch: Colors.blue,
    //       ),
    //       home:
    //     ),
    //   ),
    // );
  }
}
