import 'package:flutter/material.dart';
import 'package:quickcare_user/utils/styles.dart';

class SmallButton extends StatelessWidget {
  final bool isSaving;
  final String text;
  final double? height;
  final VoidCallback onPressed;
  const SmallButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.height,
      required this.isSaving});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        color: Colors.white,
        child: Container(
          height: height,
          margin: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: buttonDecoration,
          width: double.infinity,
          child: isSaving
              ? const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 25,
                      height: 25,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '  Saving...',
                      style: buttonText,
                    )
                  ],
                )
              : Text(
                  text,
                  style: buttonText,
                ),
        ),
      ),
    );
  }
}
