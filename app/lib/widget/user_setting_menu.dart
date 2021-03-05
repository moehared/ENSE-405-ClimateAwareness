import 'package:app/auth/auth_service.dart';
import 'package:app/screens/login_screen.dart';
import 'package:app/screens/questionaire_screen/questinaires_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'build_tiles.dart';

class UserMenuPopUp extends StatelessWidget {
  // {this.iconData, this.label, this.onTap}
  UserMenuPopUp();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: BuildTile(
              iconData: Icons.settings,
              label: 'Setting',
              onTap: () {},
            ),
          ),
          Divider(color: Colors.black26),
          SizedBox(height: 5),
          BuildTile(
            iconData: Icons.sanitizer_outlined,
            label: 'Activity',
            onTap: () {},
          ),
          Divider(color: Colors.black26),
          SizedBox(height: 5),
          BuildTile(
            iconData: Icons.share,
            label: 'Share',
            onTap: () {},
          ),
          Divider(color: Colors.black26),
          SizedBox(height: 5),
          BuildTile(
            iconData: Icons.bookmark,
            label: 'Bookmark',
            onTap: () {},
          ),
          Divider(color: Colors.black26),
          SizedBox(height: 5),
          BuildTile(
            iconData: Icons.logout,
            label: 'Sign out',
            onTap: () {
              print('sign out');
              Provider.of<AuthService>(context, listen: false).signOut();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => LoginScreen()),
                ModalRoute.withName(LoginScreen.routeName),
              );
            },
          ),
          Divider(color: Colors.black26),
          SizedBox(height: 5),
          BuildTile(
            iconData: Icons.question_answer,
            label: 'Re-do Questions',
            onTap: () {
              Navigator.of(context).pushNamed(QuestinairesScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
