import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quickcare_user/controllers/sharedPreferenceController.dart';

class UserController {
  static String uri = 'https://bored-lime-codfish.cyclic.app';

  Future getUserDetails({required String userId}) async {
    try {
      String? token = await SF.getJwtToken();
      http.Response response =
          await http.get(Uri.parse('$uri/users/$userId'), headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8',
      });
      return response.body;
    } catch (e) {
      throw Exception('Failed to load user details');
    }
  }

  Future updateProfilePic(
      {required String profilePhotoLink, required String userId}) async {
    try {
      String? token = await SF.getJwtToken();
      // String? cookie = await SF.getSessionToken();
      String jsonBody = jsonEncode({
        "profilePicture": profilePhotoLink,
      });
      print(token);
      http.Response response = await http.post(
          Uri.parse('http://localhost:3000/users/$userId/profile-picture'),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonBody);
      print(response.body);
      return response.body;
    } catch (e) {
      print(e.toString());
    }
  }
}
