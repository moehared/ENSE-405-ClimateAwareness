import 'package:app/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommunityScreen extends StatelessWidget {
  static const routeName = '/CommunityScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text("Community screen")),
          RaisedButton(
            onPressed: () {
              Provider.of<AuthService>(context, listen: false).signOut();
            },
            child: Text("sign out"),
          )
        ],
      ),
    );
  }
}
