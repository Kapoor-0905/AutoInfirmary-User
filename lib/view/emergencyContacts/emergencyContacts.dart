import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quickcare_user/controllers/emergencyContactController.dart';
import 'package:quickcare_user/routeNames.dart';
import 'package:quickcare_user/utils/colors.dart';
import 'package:quickcare_user/utils/shimmers.dart';
import 'package:quickcare_user/utils/styles.dart';
import 'package:quickcare_user/view/emergencyContacts/components/contactTile.dart';

class EmergencyContacts extends StatefulWidget {
  const EmergencyContacts({super.key});

  @override
  State<EmergencyContacts> createState() => _EmergencyContactsState();
}

class _EmergencyContactsState extends State<EmergencyContacts> {
  EmergencyContactController ecController = EmergencyContactController();
  List contacts = [];
  bool isLoading = false;

  getContacts() async {
    setState(() {
      isLoading = true;
    });
    await ecController.getAllContacts().then((value) {
      setState(() {
        contacts = jsonDecode(value);
        isLoading = false;
      });
    });
    // print(contacts);
  }

  @override
  void initState() {
    super.initState();
    mounted ? getContacts() : null;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, size.height * 0.12),
        child: Container(
          padding: EdgeInsets.fromLTRB(20, size.height * 0.06, 20, 20),
          decoration: topBarDecoration,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Emergency Contacts',
                    style: heading.copyWith(color: Colors.white, fontSize: 28),
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
              const SizedBox(height: 10),
              const Text(
                'Contact emergency contacts when needed !!',
                style: smallTextWhite,
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: isLoading
                      ? const ShimmerList()
                      : contacts.isEmpty
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Lottie.network(
                                    height: size.height * 0.3,
                                    width: size.width,
                                    'https://lottie.host/9c53cf74-bbde-41c4-8186-5f65f586911e/dwd5s6pVNx.json'),
                                Text(
                                  'No contacts found',
                                  style:
                                      buttonText.copyWith(color: primaryColor),
                                )
                              ],
                            )
                          : Column(
                              children: List.generate(
                                contacts.length,
                                (index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, RouteNames.contactPage,
                                          arguments: contacts[index]);
                                    },
                                    child: ContactTile(
                                        name: contacts[index]['name'],
                                        phoneNumber: contacts[index]
                                            ['phoneNum']),
                                  );
                                },
                              ),
                            ),
                )
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {
          Navigator.pushNamed(context, RouteNames.addContact).then((value) {
            value == 'refresh' ? getContacts() : null;
          });
        },
        backgroundColor: primaryColor,
        child: const Icon(
          Icons.add,
          color: accentColor,
          size: 30,
        ),
      ),
    );
  }
}
