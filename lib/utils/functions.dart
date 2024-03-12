import 'package:intl/intl.dart';

String getMonthAndYear(String dateString) {
  DateTime dateTime = DateTime.parse(dateString);
  String monthName = DateFormat('MMMM').format(dateTime);
  String year = DateFormat('y').format(dateTime);
  return '$monthName, $year';
}