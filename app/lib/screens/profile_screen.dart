import 'package:app/widget/user_setting_menu.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = '/ProfileScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.more_vert_rounded,
            ),
            onPressed: () => bottomSheet(context),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text("Profile screen")),
        ],
      ),
    );
  }

  void bottomSheet(context) {
    showModalBottomSheet(
      context: context,
      elevation: 4,
      builder: (_) => UserMenuPopUp(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
    );
  }
}
