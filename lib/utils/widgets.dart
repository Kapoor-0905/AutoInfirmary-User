import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quickcare_user/utils/colors.dart';

errorToast({required String message}) {
  Fluttertoast.showToast(
    backgroundColor: const Color(0xFFff3333),
    textColor: Colors.white,
    msg: message,
  );
}

successToast({required String message}) {
  Fluttertoast.showToast(
    backgroundColor: Color.fromARGB(255, 15, 152, 27),
    textColor: Colors.white,
    msg: message,
  );
}

normalToast({required String message}) {
  Fluttertoast.showToast(
      msg: message, backgroundColor: primaryColor, textColor: Colors.white);
}
