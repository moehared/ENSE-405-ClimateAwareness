import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  static const routeName = '/ChatScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        title: Text('Chat'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.notifications,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text("Chat screen")),
        ],
      ),
    );
  }
}
