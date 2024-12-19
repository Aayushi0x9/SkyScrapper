import 'package:flutter/material.dart';
import 'package:weather_app/screen/home/home_screen.dart';
import 'package:weather_app/screen/splash/splash_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String home = '/home';

  static Map<String, WidgetBuilder> routes = {
    AppRoutes.home: (context) => const HomeScreen(),
    AppRoutes.splash: (context) => const SplashScreen(),
  };
}
