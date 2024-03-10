import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String uniqueOrgCode;
  String address;
  String password;
  String userName;

  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.uniqueOrgCode,
    required this.address,
    required this.password,
    required this.userName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'uniqueOrgCode': uniqueOrgCode,
      'address': address,
      'password': password,
      'userName': userName,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      email: map['email'] as String,
      phoneNumber: map['phoneNumber'] as String,
      uniqueOrgCode: map['uniqueOrgCode'] as String,
      address: map['address'] as String,
      password: map['password'] as String,
      userName: map['userName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
