import 'package:flutter/cupertino.dart';

class UserModel {
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  UserModel({
    @required this.firstName,
    @required this.lastName,
    @required this.email,
    @required this.password,
  });
// more to come for location

  Map<String, dynamic> toJson() {
    return {
      'firstName': this.firstName,
      'lastName': this.lastName,
      'email': this.email,
      'password': this.password,
    };
  }
}
