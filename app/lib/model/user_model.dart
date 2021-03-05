import 'package:flutter/cupertino.dart';

class UserModel with ChangeNotifier {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  bool showOnMap;
  final double carbonScore;

  UserModel({
    @required this.firstName,
    @required this.lastName,
    @required this.email,
    @required this.password,
    @required this.carbonScore,
    this.showOnMap = false,
  });
// more to come for location

  void showUserOnMap() {
    showOnMap = !showOnMap;
    notifyListeners();
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': this.firstName,
      'lastName': this.lastName,
      'email': this.email,
      'password': this.password,
      'showOnMap': this.showOnMap,
      'carbonScore': this.carbonScore,
    };
  }
}
