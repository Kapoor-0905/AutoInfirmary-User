import 'package:http/http.dart' as http;
import 'package:quickcare_user/controllers/sharedPreferenceController.dart';
import 'package:quickcare_user/models/emergencyContact.dart';
import 'package:quickcare_user/utils/constants.dart';
import 'package:quickcare_user/utils/widgets.dart';

class EmergencyContactController {
  static String uri = ServerEndpoints.currentServer;

  Future createEmergencyContact({required EmergencyContact contact}) async {
    try {
      String? token = await SF.getJwtToken();

      http.Response response = await http.post(
        Uri.parse('$uri/contacts'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: contact.toJson(),
      );
      return {'body': response.body, 'statuscode': response.statusCode};
    } catch (e) {
      errorToast(message: e.toString());
    }
  }

  Future getAllContacts() async {
    try {
      String? token = await SF.getJwtToken();
      String? id = await SF.getUserId();
      http.Response response = await http.get(
        Uri.parse('$uri/contacts/$id'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      return response.body;
    } catch (e) {
      errorToast(message: e.toString());
    }
  }

  Future deleteContact({required String contactId}) async {
    try {
      String? token = await SF.getJwtToken();
      String? id = await SF.getUserId();
      http.Response response = await http.delete(
        Uri.parse('$uri/contacts/$id/$contactId'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      return response.body;
    } catch (e) {
      errorToast(message: e.toString());
    }
  }
}
