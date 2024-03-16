// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AppointmentBooking {
  String fullName;
  String email;
  String department;
  String location;
  String issueFacing;
  String bookingDate;
  String userId;

  AppointmentBooking({
    required this.fullName,
    required this.email,
    required this.department,
    required this.location,
    required this.issueFacing,
    required this.bookingDate,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fullName': fullName,
      'email': email,
      'department': department,
      'location': location,
      'issueFacing': issueFacing,
      'bookingDate': bookingDate,
      'userId': userId,
    };
  }

  factory AppointmentBooking.fromMap(Map<String, dynamic> map) {
    return AppointmentBooking(
      fullName: map['fullName'] as String,
      email: map['email'] as String,
      department: map['department'] as String,
      location: map['location'] as String,
      issueFacing: map['issueFacing'] as String,
      bookingDate: map['bookingDate'] as String,
      userId: map['userId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppointmentBooking.fromJson(String source) =>
      AppointmentBooking.fromMap(json.decode(source) as Map<String, dynamic>);
}
