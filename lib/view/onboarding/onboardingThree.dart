import 'package:flutter/material.dart';
import 'package:quickcare_user/routeNames.dart';
import 'package:quickcare_user/utils/colors.dart';
import 'package:quickcare_user/utils/styles.dart';
import 'package:quickcare_user/utils/widgets/bigButton.dart';

class OnboardingThree extends StatelessWidget {
  const OnboardingThree({super.key});

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
            Text(
              'Emergency and First aid',
              style: heading,
            ),
            SizedBox(
                height: size.height * 0.4,
                child: Image.asset(
                  'assets/images/emergencyandfirstaid.png',
                )),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                    text:
                        'In an Emergency? Book as emergency and get well soon...',
                    style: normalText,
                    children: [
                      TextSpan(
                        text: '\n\nFirst aid also available',
                        style: normalTextBold,
                      )
                    ]),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 8,
                  backgroundColor: primaryColor.withOpacity(0.4),
                ),
                const SizedBox(width: 2),
                CircleAvatar(
                  radius: 8,
                  backgroundColor: primaryColor.withOpacity(0.6),
                ),
                const SizedBox(width: 2),
                CircleAvatar(
                  radius: 8,
                  backgroundColor: primaryColor,
                ),
              ],
            )
          ],
        ),
      ),
      bottomSheet: BigButton(
          text: 'Finish',
          onPressed: () {
            Navigator.pushReplacementNamed(context, RouteNames.login);
          }),
    );
  }
}
