import 'package:flutter/material.dart';
import 'package:quickcare_user/routeNames.dart';
import 'package:quickcare_user/view/home/home.dart';
import 'package:quickcare_user/view/splash/splashScreen.dart';

final Map<String, WidgetBuilder> routes = {
  RouteNames.splash: (context) => const SplashScreen(),
  RouteNames.home: (context) => const Home(),
};
