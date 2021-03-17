import 'package:app/auth/auth_wrapper.dart';
import 'package:app/screens/emailverification_screen.dart';
import 'package:app/screens/login_screen.dart';
import 'package:app/screens/personalized_details.dart';
import 'package:app/screens/personalized_view_all_screen.dart';
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
      case PersonalizedDetailsTips.routeName:
        return MaterialPageRoute(
            builder: (_) =>
                PersonalizedDetailsTips(settings.arguments as String));
      case PersonalizedViewAllScreen.PERSONALIZED_VIEW_ALL:
        return MaterialPageRoute(builder: (_) => PersonalizedViewAllScreen());

      default:
        return MaterialPageRoute(builder: (_) => AuthWrapper());
    }
  }
}
