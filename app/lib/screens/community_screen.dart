import 'package:app/screens/filter_screen/all_screen.dart';
import 'package:app/screens/filter_screen/article_screen.dart';
import 'package:app/screens/filter_screen/media.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final _firebase = FirebaseFirestore.instance;

class CommunityScreen extends StatefulWidget {
  static const routeName = '/CommunityScreen';
  static const COMMUNITY_COLLECTION = 'community_post';

  @override
  _CommunityScreenState createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          brightness: Brightness.light,
          title: Text('Community'),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.add,
                ),
                onPressed: () {} //_addPost,
                ),
          ],
        ),
        body: Container(
          constraints: BoxConstraints.expand(
              width: double.infinity, height: media.size.height),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/space.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 30,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorLight,
                  // borderRadius: BorderRadius.circular(
                  //   10,
                  // ),
                ),
                child: TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    // borderRadius: BorderRadius.circular(
                    //   10.0,
                    // ),
                    color: Theme.of(context).accentColor,
                  ),
                  tabs: [
                    Text('All'),
                    Text('Article'),
                    Text('Media'),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    AllScreen(),
                    ArticleScreen(),
                    MediaScreen(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // void _addPost() {
  //   // var post = userRef.child('/community_post').push();
  //   Map<String, dynamic> data = {
  //     'title': 'test1',
  //     'link': 'www.123test.com',
  //     'desc': 'this is a test'
  //   };
  //   _firebase.collection(CommunityScreen.COMMUNITY_COLLECTION).add(data);
  //   // post.set(data);
  //   print('data saved');
  // }
}
