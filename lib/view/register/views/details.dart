import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quickcare_user/controllers/authController.dart';
import 'package:quickcare_user/controllers/sharedPreferenceController.dart';
import 'package:quickcare_user/models/user.dart';
import 'package:quickcare_user/routeNames.dart';
import 'package:quickcare_user/utils/colors.dart';
import 'package:quickcare_user/utils/styles.dart';
import 'package:quickcare_user/utils/widgets.dart';
import 'package:quickcare_user/utils/widgets/customTextField.dart';
import 'package:quickcare_user/utils/widgets/smallButton.dart';

class Details extends StatefulWidget {
  final Map<String, String> args;
  const Details({super.key, required this.args});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  AuthController auth = AuthController();
  String firstName = '';
  String lastName = '';
  String phoneNumber = '';
  String uniqueOrgCode = '';
  String address = '';
  bool isSaving = false;

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
              const SizedBox(height: 20),
              const Text(
                'Create Account',
                style: heading,
              ),
              Divider(
                color: primaryColor,
                thickness: 0.5,
                endIndent: size.width * 0.3,
                indent: size.width * 0.3,
              ),
              const Text(
                'Details',
                style: normalText,
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
                      hintText: 'Full Name',
                      onChanged: (p0) {
                        setState(() {
                          firstName = p0.split(" ").first;
                          lastName = p0.split(" ").last;
                        });
                      },
                      keyboardType: TextInputType.name,
                    ),
                    CustomTextField(
                      hintText: 'Phone Number',
                      onChanged: (p0) {
                        setState(() {
                          phoneNumber = p0;
                        });
                      },
                      keyboardType: TextInputType.phone,
                    ),
                    CustomTextField(
                      hintText: 'Unique Organization Code',
                      onChanged: (p0) {
                        setState(() {
                          uniqueOrgCode = p0;
                        });
                      },
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.characters,
                    ),
                    CustomTextField(
                      hintText: 'Address',
                      onChanged: (p0) {
                        setState(() {
                          address = p0;
                        });
                      },
                      keyboardType: TextInputType.streetAddress,
                    ),
                    const SizedBox(height: 20),
                    SmallButton(
                        isSaving: isSaving,
                        text: 'Create Account',
                        onPressed: () async {
                          setState(() {
                            isSaving = true;
                          });
                          User user = User(
                              profilePicture: "",
                              password: widget.args['password']!,
                              firstName: firstName,
                              lastName: lastName,
                              email: widget.args['email']!,
                              phoneNum: phoneNumber,
                              uniqueOrgCode: uniqueOrgCode,
                              address: address);
                          // print(user.toMap());
                          auth
                              .createUser(
                                  user: user,
                                  onFailed: (value) {
                                    errorToast(message: value);
                                  })
                              .then((value) {
                            Map<String, dynamic> jsonData = jsonDecode(value);
                            print('From register: $jsonData');
                            SF.saveSessionToken(jsonData['sessionToken']['auth']
                                ['sessionToken']);
                            SF.saveUserId(jsonData['sessionToken']['id']);
                            SF.saveJwtToken(jsonData['token']);
                            setState(() {
                              isSaving = false;
                            });
                            successToast(message: jsonData['message']);
                            Navigator.pushReplacementNamed(
                                context, RouteNames.home);
                          });
                        }),
                    const SizedBox(height: 15),
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
