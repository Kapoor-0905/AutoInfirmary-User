import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:quickcare_user/controllers/emergencyContactController.dart';
import 'package:quickcare_user/controllers/sharedPreferenceController.dart';
import 'package:quickcare_user/models/emergencyContact.dart';
import 'package:quickcare_user/utils/colors.dart';
import 'package:quickcare_user/utils/styles.dart';
import 'package:quickcare_user/utils/widgets.dart';
import 'package:quickcare_user/utils/widgets/customTextField.dart';
import 'package:quickcare_user/utils/widgets/iconBox.dart';
import 'package:quickcare_user/utils/widgets/smallButton.dart';
import 'package:quickcare_user/view/emergencyContacts/components/phoneContactPanel.dart';

class AddContact extends StatefulWidget {
  const AddContact({super.key});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  Map<String, dynamic> importedContact = {};
  List<Contact> phonecontacts = [];
  String userId = "";
  bool isSaving = false;
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  late TextEditingController relationshipController;
  final EmergencyContactController ecController = EmergencyContactController();

  importContact() async {
    await FlutterContacts.requestPermission();
    List<Contact> contacts =
        await FlutterContacts.getContacts(withProperties: true);
    setState(() {
      phonecontacts = contacts;
    });

    String? temp = await SF.getUserId();
    setState(() {
      userId = temp!;
    });
    print(userId);
  }

  saveContact() async {
    setState(() {
      isSaving = true;
    });
    EmergencyContact contact = EmergencyContact(
        userId: userId,
        name: nameController.text,
        phoneNum: phoneController.text,
        email: emailController.text,
        relationship: relationshipController.text);
    await ecController.createEmergencyContact(contact: contact).then((value) {
      if (value['statuscode'] == 200) {
        nameController.clear();
        phoneController.clear();
        emailController.clear();
        relationshipController.clear();
        successToast(message: 'Contact added successfully');
        setState(() {
          isSaving = false;
        });
      } else if (value['statuscode'] == 400) {
        String body = value['body'];
        Map<String, dynamic> de = jsonDecode(body);
        errorToast(message: de['message']);
      } else {
        errorToast(message: 'Something went wrong');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    emailController = TextEditingController();
    relationshipController = TextEditingController();
    importContact();
  }

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
                              'Add Contact',
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
                          'Add a new contact to your emergency list...\nor import from your address book',
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomTextField(
                                    textCapitalization:
                                        TextCapitalization.words,
                                    controller: nameController,
                                    hintText: 'Full Name',
                                    onChanged: (p0) {
                                      setState(() {
                                        nameController.text = p0;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 15),
                            const IconBox(
                              icon: 'assets/icons/edit.png',
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomTextField(
                                    keyboardType: TextInputType.phone,
                                    controller: phoneController,
                                    hintText: 'Phone Number',
                                    onChanged: (p0) {
                                      setState(() {
                                        phoneController.text = p0;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 15),
                            const IconBox(
                              icon: 'assets/icons/edit.png',
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomTextField(
                                    keyboardType: TextInputType.emailAddress,
                                    controller: emailController,
                                    hintText: 'Email Address',
                                    onChanged: (p0) {
                                      setState(() {
                                        emailController.text = p0;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 15),
                            const IconBox(
                              icon: 'assets/icons/edit.png',
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomTextField(
                                    textCapitalization:
                                        TextCapitalization.words,
                                    controller: relationshipController,
                                    hintText: 'Relationship',
                                    onChanged: (p0) {
                                      setState(() {
                                        relationshipController.text = p0;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 15),
                            const IconBox(
                              icon: 'assets/icons/edit.png',
                            )
                          ],
                        ),
                        const SizedBox(height: 50),
                        SmallButton(
                            isSaving: isSaving,
                            text: 'Save',
                            onPressed: () {
                              nameController.text.isEmpty ||
                                      phoneController.text.isEmpty ||
                                      emailController.text.isEmpty ||
                                      relationshipController.text.isEmpty
                                  ? errorToast(
                                      message: 'Please flll all fields')
                                  : saveContact();
                            })
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return PhoneContactPanel(contacts: phonecontacts);
              }).then((value) {
            setState(() {
              if (value != null) {
                importedContact = value;
                nameController.text = importedContact['name'];
                phoneController.text = importedContact['phone'];
                emailController.text = importedContact['email'];
                relationshipController.clear();
              }
            });
          });
        },
        backgroundColor: primaryColor,
        child: SizedBox(
          width: 22,
          child: Image.asset('assets/icons/import.png'),
        ),
      ),
    );
  }
}
