import 'package:quickcare_user/routeNames.dart';
import 'package:quickcare_user/routes.dart';
import 'package:quickcare_user/utils/colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuickCare',
      theme: ThemeData(
        scaffoldBackgroundColor: backgroundColor,
        fontFamily: 'Nunito',
      ),
      initialRoute: RouteNames.splash,
      routes: routes,
    );
  }
}
