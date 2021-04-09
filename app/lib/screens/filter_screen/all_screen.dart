import 'package:app/widget/user_post_stream.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AllScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("Time now is :${Timestamp.now().toDate().toLocal()}\n");
    return Column(
      children: [
        UserPostStream(
          filterByArticle: false,
          filterByMedia: false,
        ),
      ],
    );
  }

  // print('Youtube Video URL is valid? ' + (isValid ? 'yes' : 'no'));
}
