import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:quickcare_user/controllers/authController.dart';
import 'package:quickcare_user/controllers/sharedPreferenceController.dart';
import 'package:quickcare_user/routeNames.dart';
import 'package:quickcare_user/utils/colors.dart';
import 'package:quickcare_user/utils/functions.dart';
import 'package:quickcare_user/utils/styles.dart';
import 'package:quickcare_user/utils/widgets.dart';
import 'package:quickcare_user/utils/widgets/customTextField.dart';
import 'package:quickcare_user/utils/widgets/smallButton.dart';

class Login extends StatefulWidget {
  final String email;
  const Login({super.key, this.email = ''});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TextEditingController emailController;
  AuthController auth = AuthController();
  bool _obscureText = true;
  String email = '';
  String password = "";
  bool isSaving = false;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController(text: widget.email);
    getSFData();
  }

  getSFData() async {
    String? st = await SF.getSessionToken();
    String? ut = await SF.getUserId();
    String? jt = await SF.getJwtToken();
    print(st);
    print(ut);
    print(jt);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Login',
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
                      controller: emailController,
                      hintText: 'Email Address',
                      onChanged: (p0) {
                        setState(() {
                          email = p0;
                        });
                      },
                      keyboardType: TextInputType.emailAddress,
                    ),
                    CustomTextField(
                      hintText: 'Password',
                      onChanged: (p0) {
                        setState(() {
                          password = p0;
                        });
                      },
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
                    const SizedBox(height: 20),
                    SmallButton(
                        isSaving: isSaving,
                        text: 'Login',
                        onPressed: () {
                          setState(() {
                            isSaving = true;
                          });
                          isValidEmail(email)
                              ? auth
                                  .login(email: email, password: password)
                                  .then((value) {
                                  print(value);
                                  value.length == 1
                                      ? errorToast(message: value['error'])
                                      : {
                                          SF.saveSessionToken(value['user']
                                              ['auth']['sessionToken']),
                                          SF.saveUserId(value['user']['id']),
                                          SF.saveJwtToken(value['token']),
                                          setState(() {
                                            isSaving = false;
                                          }),
                                          Navigator.pushReplacementNamed(
                                              context, RouteNames.home),
                                        };
                                })
                              : errorToast(
                                  message: 'Please enter a valid email');
                        }),
                    const SizedBox(height: 15),
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
                    const SizedBox(height: 15),
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
                    const SizedBox(height: 45),
                    Text.rich(
                      TextSpan(
                          text: 'New Here...? ',
                          style: smallText,
                          children: [
                            TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.of(context)
                                        .pushNamed(RouteNames.register);
                                  },
                                text: 'Create Account',
                                style: smallText.copyWith(
                                    fontWeight: FontWeight.bold))
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
