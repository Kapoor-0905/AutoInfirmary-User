import 'package:quickcare_user/controllers/sharedPreferenceController.dart';
import 'package:quickcare_user/models/emergencyBooking.dart';
import 'package:http/http.dart' as http;
import 'package:quickcare_user/utils/widgets.dart';

class EmergencyBookingController {
  static String uri = "https://bored-lime-codfish.cyclic.app";

  Future createEmergencyBooking(
      {required EmergencyBookingModel emergencyBooking}) async {
    try {
      String? token = await SF.getJwtToken();
      http.Response response = await http.post(
        Uri.parse('$uri/emergency'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: emergencyBooking.toJson(),
      );
      return response.body;
    } catch (e) {
      errorToast(message: e.toString());
    }
  }

  Future getEmergencyBooking() async {
    try {
      String? token = await SF.getJwtToken();
      String? id = await SF.getUserId();
      http.Response response = await http.get(
        Uri.parse('$uri/emergency/$id'),
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
