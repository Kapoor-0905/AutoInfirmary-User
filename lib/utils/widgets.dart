import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
