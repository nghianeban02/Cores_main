import 'dart:async';

import 'package:cores_project/screen/home_screen.dart';
import 'package:cores_project/screen/login/login_screen.dart';
import 'package:cores_project/storage/app_preferences.dart';
import 'package:cores_project/utils/app_assets.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () =>
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AppPreferencesImpl().getToken != null ? HomeScreen() : LoginScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage(AppAssets.splash))),
      ),
    );
  }
}
