import 'package:flutter/material.dart';
import 'package:quickcare_user/utils/colors.dart';
import 'package:quickcare_user/utils/styles.dart';
import 'package:quickcare_user/utils/widgets/iconBox.dart';

class SettingTile extends StatelessWidget {
  final String title;
  final String prefixImage;

  const SettingTile(
      {super.key, required this.prefixImage, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: containerDecoration,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                        color: primaryColor.withOpacity(0.2),
                        shape: BoxShape.rectangle),
                    child: Image.asset(prefixImage,
                        color: primaryColor, scale: 5),
                  ),
                  const SizedBox(width: 15),
                  Text(title, style: smallTextBold),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              // makePhoneCall(phoneNumber);
            },
            child: const IconBox(icon: 'assets/icons/arrow.png'),
          )
        ],
      ),
    );
  }
}
