import 'package:app/auth/auth_service.dart';
import 'package:app/screens/login_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConfirmEmail extends StatelessWidget {
  static const String routeName = "/ConfirmEmail";

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('verification '),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            'An email has just been sent to ${provider.currentUser.email ?? 'error fetching email'}, Click the link provided to complete registration. To re-send verifications email, ',
                        style: TextStyle(
                            fontFamily: 'Roboto-Regular',
                            fontSize: 18,
                            color: Colors.black),
                      ),
                      TextSpan(
                        text: 'Click here \n\n\n',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            provider.sendEmailVerification();
                          },
                        style: TextStyle(
                            fontFamily: 'Roboto-Regular',
                            fontSize: 18,
                            color: Color(0xff112BF4)),
                      ),
                      TextSpan(
                        text: 'If you are already verified, please ',
                        style: TextStyle(
                            fontFamily: 'Roboto-Regular',
                            fontSize: 18,
                            color: Colors.black),
                      ),
                      TextSpan(
                        text: 'Sign in',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            provider.signOut();
                            Navigator.of(context)
                                .pushReplacementNamed(LoginScreen.routeName);
                          },
                        style: TextStyle(
                            fontFamily: 'Roboto-Regular',
                            fontSize: 18,
                            color: Color(0xff112BF4)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
