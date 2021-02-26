import 'package:app/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("auth wrapper"),
      ),
      body: Center(
        child: FlatButton(
          child: Text("Sign in"),
          onPressed: () {
            Provider.of<AuthService>(context, listen: false)
                .signIn(email: "test@gmail.com", password: "12345678");
          },
        ),
      ),
    );
  }
}
