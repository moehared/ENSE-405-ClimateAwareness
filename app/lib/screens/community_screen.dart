import 'package:app/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommunityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Community"),
      ),
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
