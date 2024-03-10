import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  String firstName;
  String lastName;
  String email;
  String phoneNum;
  String uniqueOrgCode;
  String address;
  String password;

  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNum,
    required this.uniqueOrgCode,
    required this.address,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNum': phoneNum,
      'uniqueOrgCode': uniqueOrgCode,
      'address': address,
      'password': password,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      email: map['email'] as String,
      phoneNum: map['phoneNum'] as String,
      uniqueOrgCode: map['uniqueOrgCode'] as String,
      address: map['address'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
