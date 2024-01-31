import 'package:flutter/material.dart';
import 'package:quickcare_user/utils/styles.dart';

class BigButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const BigButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: buttonDecoration,
        height: 60,
        width: double.infinity,
        child: Text(
          text,
          style: buttonText,
        ),
      ),
    );
  }
}
