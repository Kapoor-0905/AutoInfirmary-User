import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class EmergencyBookingModel {
  String fullName;
  String email;
  String department;
  String location;
  String issueFacing;
  String bookingDate;
  String approxTimeOfArrival;
  bool needAmbulance;
  String userId;
  EmergencyBookingModel({
    required this.fullName,
    required this.email,
    required this.department,
    required this.location,
    required this.issueFacing,
    required this.bookingDate,
    required this.approxTimeOfArrival,
    required this.needAmbulance,
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
      'approxTimeOfArrival': approxTimeOfArrival,
      'needAmbulance': needAmbulance,
      'userId': userId,
    };
  }

  factory EmergencyBookingModel.fromMap(Map<String, dynamic> map) {
    return EmergencyBookingModel(
      fullName: map['fullName'] as String,
      email: map['email'] as String,
      department: map['department'] as String,
      location: map['location'] as String,
      issueFacing: map['issueFacing'] as String,
      bookingDate: map['bookingDate'] as String,
      approxTimeOfArrival: map['approxTimeOfArrival'] as String,
      needAmbulance: map['needAmbulance'] as bool,
      userId: map['userId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory EmergencyBookingModel.fromJson(String source) =>
      EmergencyBookingModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
