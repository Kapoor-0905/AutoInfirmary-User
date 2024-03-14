import 'dart:convert';

import 'package:quickcare_user/models/user.dart';
import 'package:http/http.dart' as http;

class AuthController {
  static String uri = 'http://192.168.216.15:3000';

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
}
