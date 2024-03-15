import 'package:http/http.dart' as http;
import 'package:quickcare_user/models/appointmentBooking.dart';
import 'package:quickcare_user/utils/widgets.dart';

class AppointmentBookingController {
  static String uri = "http://localhost:3000";
  Future bookAppointment(
      {required AppointmentBooking appointmentBooking}) async {
    try {
      http.Response response = await http.post(Uri.parse('$uri/appointments'));
    } catch (e) {
      errorToast(message: e.toString());
    }
  }
}
