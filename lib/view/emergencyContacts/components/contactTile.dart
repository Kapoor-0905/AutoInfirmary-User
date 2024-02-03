import 'package:flutter/material.dart';
import 'package:quickcare_user/utils/colors.dart';
import 'package:quickcare_user/utils/styles.dart';
import 'package:quickcare_user/utils/widgets/iconBox.dart';

class ContactTile extends StatelessWidget {
  final String name;
  final String phoneNumber;
  const ContactTile({super.key, required this.name, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: containerDecoration,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.2),
                      shape: BoxShape.circle),
                  child: Image.asset('assets/icons/person.png',
                      color: primaryColor, scale: 10.5),
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: smallTextBold),
                    Text(phoneNumber, style: smallText)
                  ],
                )
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        const IconBox(icon: 'assets/icons/call.png')
      ],
    );
  }
}
