import 'package:http/http.dart' as http;
import 'package:quickcare_user/controllers/sharedPreferenceController.dart';
import 'package:quickcare_user/models/appointmentBooking.dart';
import 'package:quickcare_user/utils/widgets.dart';

class AppointmentBookingController {
  static String uri = "http://localhost:3000";
  Future bookAppointment(
      {required AppointmentBooking appointmentBooking}) async {
    try {
      String? token = await SF.getJwtToken();

      http.Response response = await http.post(
        Uri.parse('$uri/appointments'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: appointmentBooking.toJson(),
      );
      return response.body;
    } catch (e) {
      errorToast(message: e.toString());
    }
  }

  Future getAppointmentBookings() async {
    try {
      String? token = await SF.getJwtToken();
      String? userId = await SF.getUserId();

      http.Response response = await http.get(
        Uri.parse('$uri/appointments/$userId'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      return response.body;
    } catch (e) {}
  }
}
