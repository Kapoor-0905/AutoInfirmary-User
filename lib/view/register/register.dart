import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:quickcare_user/routeNames.dart';
import 'package:quickcare_user/utils/colors.dart';
import 'package:quickcare_user/utils/styles.dart';
import 'package:quickcare_user/utils/widgets/customTextField.dart';
import 'package:quickcare_user/utils/widgets/smallButton.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _obscureText = true;
  bool _obscureTextConfirm = true;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Text(
                'Create Account',
                style: heading,
              ),
              SizedBox(
                  height: size.height * 0.3,
                  child: Image.asset(
                    'assets/images/login.png',
                    scale: 1.7,
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  children: [
                    CustomTextField(
                      hintText: 'Email Address',
                      onChanged: (p0) {},
                      keyboardType: TextInputType.emailAddress,
                    ),
                    CustomTextField(
                      hintText: 'Password',
                      onChanged: (p0) {},
                      obscureText: _obscureText,
                      keyboardType: TextInputType.visiblePassword,
                      suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                          child: SizedBox(
                            width: 10,
                            child: Image.asset(
                              _obscureText
                                  ? 'assets/icons/eye_hide.png'
                                  : 'assets/icons/eye.png',
                              scale: 4,
                            ),
                          )),
                    ),
                    CustomTextField(
                      hintText: 'Confirm Password',
                      onChanged: (p0) {},
                      obscureText: _obscureTextConfirm,
                      keyboardType: TextInputType.visiblePassword,
                      suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _obscureTextConfirm = !_obscureTextConfirm;
                            });
                          },
                          child: SizedBox(
                            width: 10,
                            child: Image.asset(
                              _obscureTextConfirm
                                  ? 'assets/icons/eye_hide.png'
                                  : 'assets/icons/eye.png',
                              scale: 4,
                            ),
                          )),
                    ),
                    const SizedBox(height: 10),
                    SmallButton(
                        text: 'Next',
                        onPressed: () {
                          Navigator.pushNamed(context, RouteNames.details);
                        }),
                    const SizedBox(height: 12),
                    const Row(
                      children: [
                        Expanded(
                          child: Divider(
                            indent: 20,
                            color: primaryColor,
                            thickness: 1,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text('OR', style: normalText),
                        SizedBox(width: 10),
                        Expanded(
                          child: Divider(
                            endIndent: 20,
                            color: primaryColor,
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          child: SizedBox(
                              height: 30,
                              child: Image.asset('assets/icons/google.png')),
                        ),
                        GestureDetector(
                          child: SizedBox(
                              height: 30,
                              child: Image.asset('assets/icons/twitter.png')),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Text.rich(
                      TextSpan(
                          text: 'Exisiting User...? ',
                          style: smallText,
                          children: [
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushNamed(
                                      context, RouteNames.login);
                                },
                              text: 'Login',
                              style: smallText.copyWith(
                                  fontWeight: FontWeight.bold),
                            )
                          ]),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
