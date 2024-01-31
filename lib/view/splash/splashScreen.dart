import 'package:flutter/material.dart';
import 'package:quickcare_user/utils/styles.dart';
import 'package:quickcare_user/utils/widgets/bigButton.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to',
              style: heading,
            ),
            Image.asset('assets/images/splash.png'),
            Text(
              'Quickcare',
              style: heading,
            )
          ],
        ),
      ),
      bottomSheet: BigButton(text: 'Get Started', onPressed: () {}),
    );
  }
}
