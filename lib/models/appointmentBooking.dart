import 'dart:convert';

class AppointmentBooking {
  String fullName;
  String email;
  String department;
  String location;
  String issueFacing;
  String bookingDate;

  AppointmentBooking({
    required this.fullName,
    required this.email,
    required this.department,
    required this.location,
    required this.issueFacing,
    required this.bookingDate,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fullName': fullName,
      'email': email,
      'department': department,
      'location': location,
      'issueFacing': issueFacing,
      'bookingDate': bookingDate,
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
    );
  }

  String toJson() => json.encode(toMap());

  factory AppointmentBooking.fromJson(String source) =>
      AppointmentBooking.fromMap(json.decode(source) as Map<String, dynamic>);
}
