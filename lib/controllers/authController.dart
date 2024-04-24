import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quickcare_user/controllers/sharedPreferenceController.dart';
import 'package:quickcare_user/models/user.dart';
import 'package:http/http.dart' as http;

class AuthController {
  static String uri = 'https://bored-lime-codfish.cyclic.app';

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
      print('yaha tak aaya');
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

      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      print('Response code : ${response.statusCode}');
      if (response.statusCode == 200) {
        return responseBody;
      } else if (response.statusCode == 403) {
        if (responseBody['message'] == "User not found") {
          return {'error': "User not found"};
        } else if (responseBody['message'] == "Password does not match!") {
          return {'error': "Wrong Password!"};
        }
      }
      // SF.saveSessionToken(response.body);
    } catch (e) {
      print('error aaya');
      print(e.toString());
    }
  }

  Future logout({required VoidCallback action}) async {
    await SF.saveJwtToken("");
    await SF.saveSessionToken("");
    await SF.saveUserId("");
    action();
    print('logged out and value cleared');
  }
}
