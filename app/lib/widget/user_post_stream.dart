import 'package:app/auth/auth_service.dart';
import 'package:app/model/community_post.dart';
import 'package:app/screens/community_screen.dart';
import 'package:app/widget/post_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constant.dart';

class UserPostStream extends StatelessWidget {
  const UserPostStream({this.filterByArticle, this.filterByMedia});

  final bool filterByArticle;
  final bool filterByMedia;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthService>(context, listen: false);
    return StreamBuilder<QuerySnapshot>(
        stream: user.firestore
            .collection(CommunityScreen.COMMUNITY_COLLECTION)
            .orderBy('date', descending: true)
            .snapshots(),
        builder: (ctx, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text('No Data exists'),
            );
          }
          // final post = filterByArticle ? snapshot.data.docs.reversed;
          final post = filterByArticle
              ? snapshot.data.docs.where((element) {
                  return element.data().containsValue(ARTICLE);
                }).toList()
              // .reversed
              : filterByMedia
                  ? snapshot.data.docs.where((element) {
                      return element.data().containsValue(MEDIA);
                    }).toList()
                  // .reversed
                  : snapshot.data.docs;
          // List<UserPost> userPost = [];
          List<Widget> widgets = [];
          var id;
          UserPost userData;
          for (var p in post) {
            final data = p.data();
            id = p.id;
            userData = UserPost.fromJson(data);
            // print("title : ${userData.title}\n");
            // print("desc : ${userData.desc}\n");
            widgets.add(ReusablePostCard(
              post: userData,
              id: id,
              uuid: userData.uuid,
            ));
          }
          return Expanded(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                // reverse: true,
                physics: BouncingScrollPhysics(),
                itemCount: widgets.length,
                itemBuilder: (_, index) {
                  return widgets[index];
                  // return ReusablePostCard(
                  //   id: id,
                  //   post: userPost[index],
                  // );
                }),
          );
        });
  }
}
