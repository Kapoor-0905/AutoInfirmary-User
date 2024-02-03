import 'package:flutter/material.dart';
import 'package:quickcare_user/utils/animations.dart';
import 'package:quickcare_user/utils/styles.dart';
import 'package:quickcare_user/view/onboarding/onboardingOne.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      // Navigator.pushReplacementNamed(context, RouteNames.onboardingone);
      Navigator.of(context).pushReplacement(createRoute(const OnboardingOne()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to',
              style: heading,
            ),
            Image.asset('assets/images/splash.png'),
            const Text(
              'Quickcare',
              style: heading,
            )
          ],
        ),
      ),
    );
  }
}
