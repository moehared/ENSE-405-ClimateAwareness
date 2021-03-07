import 'package:app/screens/filter_screen/all_screen.dart';
import 'package:app/screens/filter_screen/article_screen.dart';
import 'package:app/screens/filter_screen/media.dart';
import 'package:flutter/material.dart';

class CommunityScreen extends StatefulWidget {
  static const routeName = '/CommunityScreen';

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
              onPressed: () {},
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
}
