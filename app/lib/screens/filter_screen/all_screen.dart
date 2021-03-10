import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AllScreen extends StatelessWidget {
  final _firebase = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('All screen'),
          ],
        ),
      ),
    );
  }
}
