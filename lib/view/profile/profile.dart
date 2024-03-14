import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quickcare_user/controllers/sharedPreferenceController.dart';
import 'package:quickcare_user/controllers/userController.dart';
import 'package:quickcare_user/utils/colors.dart';
import 'package:quickcare_user/utils/functions.dart';
import 'package:quickcare_user/utils/styles.dart';
import 'package:quickcare_user/utils/widgets/iconBox.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // TODO: profile photo routes and api
  bool isLoading = false;
  UserController _userController = UserController();
  String? userId = '';
  Map<String, dynamic> userData = {};
  fetchUserData() async {
    setState(() {
      isLoading = true;
    });
    userId = await SF.getUserId();
    await _userController.getUserDetails(userId: userId!).then((value) {
      setState(() {
        userData = jsonDecode(value);
        Future.delayed(const Duration(seconds: 1), () {
          setState(() {
            isLoading = false;
          });
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: isLoading
            ? SizedBox(
                height: size.height,
                child: Lottie.network(
                    height: size.height * 0.5,
                    width: size.width,
                    'https://lottie.host/3d068dbd-b21c-49fb-a118-7c15f93baaba/VNKDgU6pzD.json'),
              )
            : SizedBox(
                height: size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(
                              20, size.height * 0.06, 20, 20),
                          decoration: topBarDecoration,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Profile',
                                    style: heading.copyWith(
                                        color: Colors.white, fontSize: 28),
                                  ),
                                  GestureDetector(
                                    onTap: () => Navigator.pop(context),
                                    child: Row(
                                      children: [
                                        Text(
                                          'ESC',
                                          style: smallText.copyWith(
                                              color: Colors.white
                                                  .withOpacity(0.5)),
                                        ),
                                        const SizedBox(width: 5),
                                        Icon(
                                          Icons.close,
                                          size: 15,
                                          color: Colors.white.withOpacity(0.5),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              const Text(
                                'See your profile and your past activity...',
                                style: smallTextWhite,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          '${userData['firstName']} ${userData['lastName']}',
                                          style: heading),
                                      Text(
                                          'Since ${getMonthAndYear(userData['createdAt'])}',
                                          style: smallText),
                                    ],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(22),
                                    decoration: BoxDecoration(
                                        color: primaryColor.withOpacity(0.2),
                                        shape: BoxShape.circle),
                                    child: Image.asset(
                                        'assets/icons/person.png',
                                        color: primaryColor,
                                        scale: 7.5),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  const IconBox(
                                      icon: 'assets/icons/call_outline.png'),
                                  const SizedBox(width: 15),
                                  Text('+91 ${userData['phoneNum']}',
                                      style: smallText),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const IconBox(
                                      icon: 'assets/icons/location.png'),
                                  const SizedBox(width: 15),
                                  SizedBox(
                                      width: size.width * 0.6,
                                      child: Text('${userData['address']}',
                                          style: smallText)),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const IconBox(icon: 'assets/icons/mail.png'),
                                  const SizedBox(width: 15),
                                  Text('${userData['email']}',
                                      style: smallText),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const IconBox(icon: 'assets/icons/work.png'),
                                  const SizedBox(width: 15),
                                  Text('${userData['uniqueOrgCode']}',
                                      style: smallText),
                                ],
                              ),
                              const Divider(
                                color: primaryColor,
                                thickness: 1,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Past Bookings',
                                style: heading.copyWith(fontSize: 20),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  const IconBox(icon: 'assets/icons/tick.png'),
                                  const SizedBox(width: 15),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: containerDecoration,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('09-10-2023',
                                              style: normalTextBold.copyWith(
                                                  fontSize: 12)),
                                          const Text('Issue Faced',
                                              style: smallText),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  const IconBox(icon: 'assets/icons/eye.png'),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  const IconBox(icon: 'assets/icons/cross.png'),
                                  const SizedBox(width: 15),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: containerDecoration,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('09-10-2023',
                                              style: normalTextBold.copyWith(
                                                  fontSize: 12)),
                                          const Text('Issue Faced',
                                              style: smallText),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  const IconBox(icon: 'assets/icons/eye.png'),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
