import 'package:flutter/material.dart';
import 'package:quickcare_user/utils/colors.dart';

const heading = TextStyle(
  fontSize: 32,
  fontFamily: 'Koulen',
  color: primaryColor,
);

const buttonText = TextStyle(
  fontSize: 16,
  fontFamily: 'Nunito',
  color: lightTextColor,
);

const bigTextWhite = TextStyle(
  fontSize: 18,
  fontFamily: 'Nunito',
  color: Colors.white,
);

const normalText = TextStyle(
  fontSize: 16,
  fontFamily: 'Nunito',
  color: primaryColor,
);

const normalTextWhite = TextStyle(
  fontSize: 16,
  fontFamily: 'Nunito',
  color: Colors.white,
);

const smallText = TextStyle(
  fontSize: 14,
  fontFamily: 'Nunito',
  color: primaryColor,
);

const smallTextBold = TextStyle(
  fontSize: 14,
  fontFamily: 'NunitoBold',
  color: primaryColor,
);

const smallTextWhite = TextStyle(
  fontSize: 14,
  fontFamily: 'Nunito',
  color: Colors.white,
);

const normalTextBold = TextStyle(
  fontSize: 16,
  fontFamily: 'NunitoBold',
  color: primaryColor,
);
BoxDecoration buttonDecoration = BoxDecoration(
  color: primaryColor,
  borderRadius: BorderRadius.circular(40),
);

BoxDecoration containerDecoration = BoxDecoration(
  color: accentColor.withOpacity(0.5),
  borderRadius: BorderRadius.circular(10),
);

BoxDecoration logOutContainerDecoration = BoxDecoration(
  color: dangerColor.withOpacity(0.1),
  borderRadius: BorderRadius.circular(10),
);

BoxDecoration roundedContainerDecoration = BoxDecoration(
  color: accentColor.withOpacity(0.5),
  borderRadius: BorderRadius.circular(15),
);

BoxDecoration topBarDecoration = BoxDecoration(
  color: primaryColor.withOpacity(0.8),
  borderRadius: const BorderRadius.only(
    bottomLeft: Radius.circular(15),
    bottomRight: Radius.circular(15),
  ),
);
InputDecoration textFieldDecoration(
        {required String hintText, Widget? suffixIcon}) =>
    InputDecoration(
      hintText: hintText,
      hintStyle: smallText,
      border: InputBorder.none,
      suffixIcon: suffixIcon,
    );
