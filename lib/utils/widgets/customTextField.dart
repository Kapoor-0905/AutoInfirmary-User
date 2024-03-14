import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quickcare_user/utils/colors.dart';
import 'package:quickcare_user/utils/styles.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final Function(String) onChanged;
  final Widget? suffixIcon;
  final bool? obscureText;
  final TextEditingController? controller;
  final TextCapitalization? textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.onChanged,
    this.controller,
    this.keyboardType,
    this.suffixIcon,
    this.obscureText,
    this.inputFormatters,
    this.textCapitalization,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5, top: 5),
      padding: const EdgeInsets.fromLTRB(15, 3, 0, 3),
      decoration: containerDecoration,
      child: TextField(
        controller: controller,
        textCapitalization: textCapitalization ?? TextCapitalization.none,
        inputFormatters: inputFormatters,
        onTapOutside: (p0) {
          FocusScope.of(context).unfocus();
        },
        style: smallText,
        cursorColor: primaryColor,
        keyboardType: keyboardType ?? TextInputType.text,
        obscureText: obscureText ?? false,
        onChanged: onChanged,
        decoration:
            textFieldDecoration(hintText: hintText, suffixIcon: suffixIcon),
      ),
    );
  }
}
