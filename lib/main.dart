import 'package:cores_project/navigator/navigator_key.dart';
import 'package:cores_project/navigator/router_config.dart';
import 'package:cores_project/screen/account_screen.dart';
import 'package:cores_project/screen/news/news_screen.dart';
import 'package:cores_project/screen/splash_screen.dart';
import 'package:cores_project/screen_v2/login/login_screen.dart';
import 'package:cores_project/service/network_status.dart';
import 'package:cores_project/service/wrap_provider.dart';
import 'package:cores_project/storage/app_preferences.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'bloc/account/account_cubit.dart';
import 'utils/app_color.dart';

void main() {
  runApp(ScreenUtilInit(
      designSize: const Size(414, 902), minTextAdapt: true, splitScreenMode: true, builder: (ctx, child) => const WrapProvider(child: const MyApp())));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppRoutesConf router = AppRoutesConf();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AppPreferencesImpl().init();
  }

  @override
  Widget build(BuildContext context) {
    return NetworkStatus(
        child: GetMaterialApp(
      theme: ThemeData(
          appBarTheme: AppBarTheme(backgroundColor: AppColors.primaryColor, iconTheme: IconThemeData(color: AppColors.white)),
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
          primaryColor: AppColors.primaryColor,
          inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: AppColors.white.withOpacity(0.6),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.r)),
                borderSide: BorderSide(color: AppColors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.r)),
                borderSide: BorderSide(color: AppColors.darkBlue),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.r)),
                borderSide: const BorderSide(color: AppColors.error),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.r)),
                borderSide: const BorderSide(color: AppColors.error),
              ),
              labelStyle: TextStyle(color: Colors.grey.shade800, fontWeight: FontWeight.w500, fontSize: 14))),
      debugShowCheckedModeBanner: false,
      scrollBehavior: CustomScrollBehavior(),
      navigatorKey: NavigateKeys().navigationKey,
      onGenerateRoute: router.onGenerateRoute,
      home: const SplashScreen(),
      // home: const LoginScreen(),
    ));
  }
}

class CustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}