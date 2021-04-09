import 'package:app/widget/user_post_stream.dart';
import 'package:flutter/material.dart';

class MediaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('widget build media screen\n');
    return Column(
      children: [
        UserPostStream(
          filterByArticle: false,
          filterByMedia: true,
        ),
      ],
    );
  }
}
