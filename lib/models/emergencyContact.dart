// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class EmergencyContact {
  String name;
  String phoneNum;
  String email;
  String relationship;
  String userId;

  EmergencyContact({
    required this.name,
    required this.phoneNum,
    required this.email,
    required this.relationship,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'phoneNum': phoneNum,
      'email': email,
      'relationship': relationship,
      'userId': userId,
    };
  }

  factory EmergencyContact.fromMap(Map<String, dynamic> map) {
    return EmergencyContact(
      name: map['name'] as String,
      phoneNum: map['phoneNum'] as String,
      email: map['email'] as String,
      relationship: map['relationship'] as String,
      userId: map['userId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory EmergencyContact.fromJson(String source) =>
      EmergencyContact.fromMap(json.decode(source) as Map<String, dynamic>);
}
