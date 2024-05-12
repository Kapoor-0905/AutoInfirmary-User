import 'package:flutter/material.dart';
import 'package:quickcare_user/utils/colors.dart';
import 'package:quickcare_user/utils/styles.dart';

class IconBox extends StatelessWidget {
  final String icon;
  const IconBox({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
        // margin: const EdgeInsets.only(bottom: 10),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(12),
        decoration: containerDecoration,
        child: SizedBox(
          height: 20,
          width: 20,
          child: Image.asset(
            icon,
            scale: 5,
            color: primaryColor,
          ),
        ));
  }
}
