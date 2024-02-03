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
      debugShowCheckedModeBanner: false,
      // darkTheme: ThemeData(
      //   primaryColor: primaryColorDark,
      //   appBarTheme: const AppBarTheme(
      //     iconTheme: IconThemeData(color: accentColor),
      //     backgroundColor: backgroundColorDark,
      //   ),
      // ),
      // themeMode: ThemeMode.dark,
      title: 'QuickCare',
      theme: ThemeData(
        primaryColor: primaryColor,
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: primaryColor),
          backgroundColor: backgroundColor,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: backgroundColor,
        fontFamily: 'Nunito',
      ),
      initialRoute: RouteNames.login,
      routes: routes,
    );
  }
}
