import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quickcare_user/controllers/authController.dart';
import 'package:quickcare_user/routeNames.dart';
import 'package:quickcare_user/utils/colors.dart';
import 'package:quickcare_user/utils/styles.dart';
import 'package:quickcare_user/view/settings/components/settingTile.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  AuthController authController = AuthController();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        EdgeInsets.fromLTRB(20, size.height * 0.06, 20, 20),
                    decoration: topBarDecoration,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Settings',
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
                                        color: Colors.white.withOpacity(0.5)),
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
                          'Customize your experience...',
                          style: smallTextWhite,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        SettingTile(
                            route: "",
                            prefixImage: 'assets/icons/edit.png',
                            title: 'Edit Profile'),
                        SettingTile(
                            route: RouteNames.manageEmergencyContacts,
                            prefixImage: 'assets/icons/call_outline.png',
                            title: 'Manage Emergency Contacts'),
                        SettingTile(
                            route: "",
                            prefixImage: 'assets/icons/work.png',
                            title: 'Switch Organization'),
                        SettingTile(
                            route: "",
                            prefixImage: 'assets/icons/bookmark.png',
                            title: 'View appointments'),
                        SettingTile(
                            route: "",
                            prefixImage: 'assets/icons/appearance.png',
                            title: 'Appearance'),
                        SettingTile(
                            route: RouteNames.privacyPolicy,
                            prefixImage: 'assets/icons/privacyPolicy.png',
                            title: 'Privacy Policy'),
                      ],
                    ),
                  )
                ],
              ),
              GestureDetector(
                onTap: () {
                  authController.logout(action: () {
                    Navigator.pushReplacementNamed(context, RouteNames.login);
                  });
                },
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          decoration: logOutContainerDecoration,
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: dangerColor.withOpacity(0.2),
                                    shape: BoxShape.rectangle),
                                child: Image.asset('assets/icons/logout.png',
                                    scale: 5),
                              ),
                              const SizedBox(width: 15),
                              Text('Logout',
                                  style: smallTextBold.copyWith(
                                      color: Color(0xFF6F1818))),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
