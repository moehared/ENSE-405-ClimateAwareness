import 'package:flutter/material.dart';

class ForumScreen extends StatelessWidget {
  static const routeName = '/ForumScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text("Forum screen")),
        ],
      ),
    );
  }
}
