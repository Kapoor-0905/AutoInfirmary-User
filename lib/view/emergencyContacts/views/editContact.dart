import 'package:flutter/material.dart';
import 'package:quickcare_user/utils/colors.dart';
import 'package:quickcare_user/utils/styles.dart';

class EditContact extends StatefulWidget {
  final Map<String, dynamic> args;
  const EditContact({super.key, required this.args});

  @override
  State<EditContact> createState() => _EditContactState();
}

class _EditContactState extends State<EditContact> {
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  late TextEditingController relationshipController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.args['name']);
    phoneController = TextEditingController(text: widget.args['phoneNum']);
    emailController = TextEditingController(text: widget.args['email']);
    relationshipController =
        TextEditingController(text: widget.args['relationship']);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(0, size.height * 0.02, 0, 0),
            decoration: BoxDecoration(
                color: const Color(0xFF186F65).withOpacity(0.7),
                borderRadius: BorderRadius.circular(15)),
            height: size.height * 0.6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            children: [
                              Text(
                                'SAVE',
                                style: smallText.copyWith(color: Colors.white),
                              ),
                              const SizedBox(width: 5),
                              const Icon(
                                Icons.check,
                                size: 15,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    CircleAvatar(
                      radius: 120,
                      backgroundColor: primaryColor,
                      child: Image.asset(
                        'assets/icons/person.png',
                        scale: 1.4,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: TextField(
                        onTapOutside: (event) {
                          FocusScope.of(context).unfocus();
                        },
                        cursorColor: Colors.white,
                        cursorHeight: 35,
                        controller: nameController,
                        textAlign: TextAlign.center,
                        style: heading.copyWith(color: Colors.white),
                        decoration: const InputDecoration(
                          isDense: true,
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            margin: const EdgeInsets.only(bottom: 6, top: 20),
            color: primaryColor.withOpacity(0.1),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mobile',
                  style: normalText.copyWith(color: Colors.black),
                ),
                const SizedBox(height: 5),
                TextField(
                  onTapOutside: (event) {
                    FocusScope.of(context).unfocus();
                  },
                  cursorColor: primaryColor,
                  cursorHeight: 20,
                  controller: phoneController,
                  style: normalTextBold,
                  decoration: const InputDecoration(
                    isDense: true,
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: primaryColor)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: primaryColor)),
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: primaryColor)),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            margin: const EdgeInsets.symmetric(vertical: 6),
            color: primaryColor.withOpacity(0.1),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Email',
                  style: normalText.copyWith(color: Colors.black),
                ),
                const SizedBox(height: 5),
                TextField(
                  onTapOutside: (event) {
                    FocusScope.of(context).unfocus();
                  },
                  cursorColor: primaryColor,
                  cursorHeight: 20,
                  controller: emailController,
                  style: normalTextBold,
                  decoration: const InputDecoration(
                    isDense: true,
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: primaryColor)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: primaryColor)),
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: primaryColor)),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            margin: const EdgeInsets.symmetric(vertical: 6),
            color: primaryColor.withOpacity(0.1),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Relationship',
                  style: normalText.copyWith(color: Colors.black),
                ),
                const SizedBox(height: 5),
                TextField(
                  onTapOutside: (event) {
                    FocusScope.of(context).unfocus();
                  },
                  cursorColor: primaryColor,
                  cursorHeight: 20,
                  controller: relationshipController,
                  style: normalTextBold,
                  decoration: const InputDecoration(
                    isDense: true,
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: primaryColor)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: primaryColor)),
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: primaryColor)),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
