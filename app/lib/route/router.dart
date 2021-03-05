import 'package:app/auth/auth_wrapper.dart';
import 'package:app/screens/emailverification_screen.dart';
import 'package:app/screens/login_screen.dart';
import 'package:app/screens/questionaire_screen/questinaires_screen.dart';
import 'package:app/screens/register_screen.dart';
import 'package:flutter/material.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginScreen.routeName:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case SignUpScreen.routeName:
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case ConfirmEmail.routeName:
        return MaterialPageRoute(builder: (_) => ConfirmEmail());
      case QuestinairesScreen.routeName:
        return MaterialPageRoute(builder: (_) => QuestinairesScreen());

      default:
        return MaterialPageRoute(builder: (_) => AuthWrapper());
    }
  }
}
