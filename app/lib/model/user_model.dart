import 'package:flutter/cupertino.dart';

class UserModel {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final double score;
  List tips;

  UserModel(
      {@required this.firstName,
      @required this.lastName,
      @required this.email,
      @required this.password,
      this.score,
      this.tips});
// more to come for location

  Map<String, dynamic> toJson() {
    return {
      'firstName': this.firstName,
      'lastName': this.lastName,
      'email': this.email,
      'password': this.password,
      'score': this.score,
      'personalized_data': tips,
    };
  }
}
