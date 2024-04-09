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

DateTime convertStringToDateTime(String timeString) {
  List<String> parts = timeString.split(':');
  int hour = int.parse(parts[0]);

  String minutePart = parts[1];
  int minute = int.parse(minutePart.substring(0, 2));
  String amPm = minutePart.substring(3);

  if (amPm.toLowerCase() == 'pm' && hour != 12) {
    hour += 12;
  }

  DateTime now = DateTime.now();

  return DateTime(now.year, now.month, now.day, hour, minute);
}

String formatDate(DateTime dateTime) {
  // Format DateTime object as "Month Date, Year : Hour:Minute"
  String formattedDate = DateFormat('MMMM d, y : HH:mm').format(dateTime);
  return formattedDate;
}

String getTime(DateTime dateTime) {
  String formattedDate = DateFormat('HH:mm').format(dateTime);
  return formattedDate;
}

bool isValidEmail(String email) {
  final RegExp emailRegex = RegExp(
    r'^[\w-]+(?:\.[\w-]+)*@(?:[\w-]+\.)+[a-zA-Z]{2,7}$',
  );
  return emailRegex.hasMatch(email);
}
