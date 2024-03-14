import 'package:flutter/material.dart';
import 'package:quickcare_user/utils/colors.dart';
import 'package:quickcare_user/utils/styles.dart';

class ContactPage extends StatefulWidget {
  final Map<String, dynamic> args;
  const ContactPage({super.key, required this.args});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(0, size.height * 0.06, 0, 0),
            decoration: BoxDecoration(
                color: const Color(0xFF186F65).withOpacity(0.7),
                borderRadius: BorderRadius.circular(15)),
            height: size.height * 0.6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
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
                    Text(
                      widget.args['name'],
                      style: heading.copyWith(color: Colors.white),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          children: [
                            SizedBox(
                                width: 30,
                                child: Image.asset(
                                  'assets/icons/call_outline.png',
                                  color: Colors.white,
                                )),
                            const SizedBox(width: 20),
                            const Text(
                              'Call',
                              style: normalTextWhite,
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 19, horizontal: 15),
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          children: [
                            SizedBox(
                                width: 30,
                                child: Image.asset(
                                  'assets/icons/mail.png',
                                  color: Colors.white,
                                )),
                            const SizedBox(width: 20),
                            const Text(
                              'Mail',
                              style: normalTextWhite,
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 17, horizontal: 15),
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          children: [
                            SizedBox(
                                width: 27,
                                child: Image.asset(
                                  'assets/icons/edit.png',
                                  color: Colors.white,
                                )),
                            const SizedBox(width: 20),
                            const Text(
                              'Edit',
                              style: normalTextWhite,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
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
                Text(
                  widget.args['phoneNum'],
                  style: normalTextBold,
                )
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
                Text(
                  widget.args['email'],
                  style: normalTextBold,
                )
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
                Text(
                  widget.args['relationship'],
                  style: normalTextBold,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
