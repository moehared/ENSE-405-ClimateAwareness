import 'package:app/screens/emailverification_screen.dart';
import 'package:app/screens/login_screen.dart';
import 'package:app/screens/tabs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatelessWidget {
  static const routeName = '/AuthScreen';
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user != null && !user.emailVerified) {
      // Provider.of<AuthService>(context, listen: false).sendEmailVerification();
      return ConfirmEmail();
    } else if (user != null && user.emailVerified) {
      return HomePage();
    } else {
      return LoginScreen();
    }
  }
}
