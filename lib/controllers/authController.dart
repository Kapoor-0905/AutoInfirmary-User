import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quickcare_user/controllers/sharedPreferenceController.dart';
import 'package:quickcare_user/models/user.dart';
import 'package:http/http.dart' as http;

class AuthController {
  static String uri = 'http://localhost:3000';

  Future createUser({
    required User user,
    required Function(String) onFailed,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse('$uri/auth/register'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: user.toJson(),
      );

      return response.body;
    } catch (e) {
      onFailed(e.toString());
    }
  }

  Future login({required String email, required String password}) async {
    try {
      http.Response response = await http.post(
        Uri.parse('$uri/auth/login'),
        body: jsonEncode(
          {
            'email': email,
            'password': password,
          },
        ),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      return response.body;
      // print(response.body);s
      // SF.saveSessionToken(response.body);
    } catch (e) {}
  }
}
