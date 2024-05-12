import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quickcare_user/controllers/emergencyContactController.dart';
import 'package:quickcare_user/utils/shimmers.dart';
import 'package:quickcare_user/utils/styles.dart';
import 'package:quickcare_user/view/settings/components/manageContactTile.dart';

class ManageEmergencyContacts extends StatefulWidget {
  const ManageEmergencyContacts({super.key});

  @override
  State<ManageEmergencyContacts> createState() =>
      _ManageEmergencyContactsState();
}

class _ManageEmergencyContactsState extends State<ManageEmergencyContacts> {
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
    getContacts();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, size.height * 0.1),
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
                    'Manage Emergency Contacts',
                    textScaler: TextScaler.noScaling,
                    style: heading.copyWith(color: Colors.white, fontSize: 26),
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
                'Edit or Delete your contacts',
                style: smallTextWhite,
              ),
            ],
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          getContacts();
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: isLoading
                        ? ShimmerList()
                        : Column(
                            children: List.generate(
                              contacts.length,
                              (index) {
                                return GestureDetector(
                                  onTap: () {
                                    // Navigator.pushNamed(
                                    //     context, RouteNames.contactPage,
                                    //     arguments: contacts[index]);
                                  },
                                  child: ManageContactTile(
                                      id: contacts[index]['id'],
                                      name: contacts[index]['name'],
                                      phoneNumber: contacts[index]['phoneNum']),
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
      ),
    );
  }
}
