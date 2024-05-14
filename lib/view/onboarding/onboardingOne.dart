import 'package:flutter/material.dart';
import 'package:quickcare_user/routeNames.dart';
import 'package:quickcare_user/utils/colors.dart';
import 'package:quickcare_user/utils/styles.dart';
import 'package:quickcare_user/utils/widgets/bigButton.dart';

class OnboardingOne extends StatelessWidget {
  const OnboardingOne({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, RouteNames.login, arguments: ""),
            child: Text(
              'SKIP   ',
              style: normalText.copyWith(color: Colors.grey),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Book appointments',
              style: heading,
            ),
            SizedBox(
              height: size.height * 0.4,
              child: Image.asset('assets/images/bookappointment.png'),
            ),
            const SizedBox(height: 40),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                    text:
                        'Book your appointment with the doctor before 24 hours. Get yourself checked.',
                    style: normalText,
                    children: [
                      TextSpan(
                        text: '\n\nCancel Anytime...!!',
                        style: normalTextBold,
                      )
                    ]),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 8,
                  backgroundColor: primaryColor,
                ),
                const SizedBox(width: 2),
                CircleAvatar(
                  radius: 8,
                  backgroundColor: primaryColor.withOpacity(0.6),
                ),
                const SizedBox(width: 2),
                CircleAvatar(
                  radius: 8,
                  backgroundColor: primaryColor.withOpacity(0.4),
                ),
              ],
            )
          ],
        ),
      ),
      bottomSheet: BigButton(
          text: 'Next',
          onPressed: () {
            Navigator.pushNamed(context, RouteNames.onboardingtwo);
          }),
    );
  }
}
