import 'package:app/widget/user_post_stream.dart';
import 'package:flutter/material.dart';

class ArticleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('widget build article screen\n');
    return Column(
      children: [
        UserPostStream(
          filterByArticle: true,
          filterByMedia: false,
        ),
      ],
    );
  }
}
