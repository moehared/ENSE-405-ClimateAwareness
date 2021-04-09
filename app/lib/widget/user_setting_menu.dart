import 'package:app/auth/auth_service.dart';
import 'package:app/model/community_post.dart';
import 'package:app/screens/community_post.dart';
import 'package:app/screens/login_screen.dart';
import 'package:app/screens/questionaire_screen/questinaires_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'build_tiles.dart';

class UserMenuPopUp extends StatelessWidget {
  // {this.iconData, this.label, this.onTap}
  final bool isEdit;
  final id;
  final String uuid;
  UserMenuPopUp({this.isEdit, this.id, this.uuid});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthService>(context, listen: false);
    Stream<UserPost> userPost = user.getUserPost(id);
    return isEdit == true && id != 0 && uuid.isNotEmpty
        ? StreamBuilder<UserPost>(
            stream: userPost,
            builder: (ctx, snapshot) {
              if (!snapshot.hasData) {
                return Container();
              }
              // print(
              //     "user id: ${snapshot.data.user}\n current user id: ${user.currentUser.uid}\n");
              return Container(
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    if (isEdit && snapshot.data.user == user.currentUser.uid)
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: BuildTile(
                          iconData: Icons.edit,
                          label: 'edit',
                          onTap: () => _editPost(context),
                        ),
                      ),
                    if (isEdit && snapshot.data.user == user.currentUser.uid)
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: BuildTile(
                          iconData: Icons.delete,
                          label: 'delete post',
                          onTap: () {
                            _deleteAlert(context: context, user: user, id: id);
                          },
                        ),
                      ),
                    if (!isEdit)
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: BuildTile(
                          iconData: Icons.settings,
                          label: 'Setting',
                          onTap: () {},
                        ),
                      ),
                    if (isEdit && snapshot.data.user == user.currentUser.uid)
                      Divider(color: Colors.black26),
                    SizedBox(height: 5),
                    if (!isEdit)
                      BuildTile(
                        iconData: Icons.sanitizer_outlined,
                        label: 'Activity',
                        onTap: () {},
                      ),
                    if (!isEdit)
                      Divider(
                        color: Colors.black26,
                      ),
                    if (!isEdit) SizedBox(height: 5),
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
                    if (isEdit && snapshot.data.user != user.currentUser.uid)
                      Divider(color: Colors.black26),
                    if (isEdit && snapshot.data.user != user.currentUser.uid)
                      SizedBox(height: 5),
                    if (isEdit && snapshot.data.user != user.currentUser.uid)
                      BuildTile(
                        iconData: Icons.report,
                        label: 'Report',
                        onTap: () {},
                      ),
                    if (!isEdit) Divider(color: Colors.black26),
                    SizedBox(height: 5),
                    if (!isEdit)
                      BuildTile(
                        iconData: Icons.logout,
                        label: 'Sign out',
                        onTap: () {
                          print('sign out');
                          Provider.of<AuthService>(context, listen: false)
                              .signOut();
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    LoginScreen()),
                            ModalRoute.withName(LoginScreen.routeName),
                          );
                        },
                      ),
                    if (!isEdit) Divider(color: Colors.black26),
                    if (!isEdit) SizedBox(height: 5),
                    if (!isEdit)
                      BuildTile(
                        iconData: Icons.question_answer,
                        label: 'Questionnaire',
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(QuestinairesScreen.routeName);
                        },
                      ),
                  ],
                ),
              );
            },
          )
        : Container(
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
                Divider(
                  color: Colors.black26,
                ),
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
                  label: 'Questionnaire',
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(QuestinairesScreen.routeName);
                  },
                ),
              ],
            ),
          );
  }

  void _editPost(context) async {
    final data = Provider.of<AuthService>(context, listen: false);
    final userPost = data.getUserPost(id).where((event) => event.uuid == uuid);
    final List<String> editPostList = [];
    // print("EDIT DATA IS \n");
    userPost.forEach((element) {
      // print("TITLE : ${element.title}\n DESC : ${element.desc}\n");
      editPostList.add(element.url);
      editPostList.add(element.title);
      editPostList.add(element.desc);
      editPostList.add(element.type);
      editPostList.add(element.imageUrl);
      editPostList.add(element.imagePath);
      editPostList.add(id);
    });
    Navigator.of(context)
        .pushNamed(AddPostScreen.RouteName, arguments: editPostList)
        .then((back) {
      if (back != false) {
        Navigator.of(context).pop();
      }
    });
  }
}

void _deleteAlert({context, AuthService user, id}) {
  Alert(
    context: context,
    title: 'Are you sure you want to delete post?',
    type: AlertType.warning,
    buttons: [
      DialogButton(
        child: Text(
          'yes',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          Navigator.of(context).pop(true);
        },
      ),
      DialogButton(
        child: Text(
          'no',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          Navigator.of(context).pop(false);
        },
      ),
    ],
  ).show().then((userConfirmed) {
    if (userConfirmed == true) {
      user.deletePost(id);
      Navigator.of(context).pop();
    }
  });
}
