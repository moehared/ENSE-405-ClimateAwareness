import 'package:app/screens/community_screen.dart';
import 'package:app/screens/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user != null) {
      return CommunityScreen();
    } else {
      return SignInScreen();
    }
  }
}
