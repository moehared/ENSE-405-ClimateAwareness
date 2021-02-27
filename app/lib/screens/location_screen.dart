import 'package:flutter/material.dart';

class LocationScreen extends StatelessWidget {
  static const routeName = '/LocationScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text("Location screen")),
        ],
      ),
    );
  }
}
