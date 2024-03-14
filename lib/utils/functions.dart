import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

String getMonthAndYear(String dateString) {
  DateTime dateTime = DateTime.parse(dateString);
  String monthName = DateFormat('MMMM').format(dateTime);
  String year = DateFormat('y').format(dateTime);
  return '$monthName, $year';
}

Future<void> makePhoneCall(String phoneNumber) async {
  String url = 'tel:$phoneNumber';
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    throw 'Could not launch $url';
  }
}
