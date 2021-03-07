import 'dart:io' show File;

import 'package:app/auth/auth_service.dart';
import 'package:app/screens/questionaire_screen/questinaires_screen.dart';
import 'package:app/share_pref/local_data.dart';
import 'package:app/widget/category_card.dart';
import 'package:app/widget/result_chart.dart';
import 'package:app/widget/user_setting_menu.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/ProfileScreen';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final CategoriesCards categories = CategoriesCards();
  File _image;
  final imagePicker = ImagePicker();
  double res = 0.0;

  Future getGallery() async {
    final pickedFile = await imagePicker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getCamera() async {
    final pickedFile = await imagePicker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No Camera available.');
      }
    });
  }

  @override
  void initState() {
    getLocalData(QuestinairesScreen.RESULT).then((value) {
      if (value != null) {
        setState(() {
          res = value;
          print(value);
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthService>(context, listen: false);
    final media = MediaQuery.of(context);
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
      body: Container(
        constraints: BoxConstraints.expand(
            width: double.infinity, height: media.size.height),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/space.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  UserAvatar(
                    getImage: getGallery, //getImage,
                    image: _image,
                    camera: getCamera,
                  ),
                  Text(
                    '${user.currentUser.displayName}',
                    style: TextStyle(
                        color: Colors.white, fontFamily: 'Roboto-Medium'),
                  ),
                ],
              ),
              Divider(color: Colors.black26),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                child: Text(
                  'Carbon Footprint Score',
                  style: TextStyle(
                    fontFamily: 'Roboto-Medium',
                    color: Colors.white,
                  ),
                ),
              ),
              ResultChart(res ?? 0),
              Divider(color: Colors.black26),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                child: Text(
                  'Personalized Tips',
                  style: TextStyle(
                    fontFamily: 'Roboto-Medium',
                    color: Colors.white,
                  ),
                ),
              ),
              categories,
              Divider(color: Colors.black26),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                child: Text(
                  'Achievement',
                  style: TextStyle(
                    fontFamily: 'Roboto-Medium',
                    color: Colors.white,
                  ),
                ),
              ),
              categories,
            ],
          ),
        ),
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

class UserAvatar extends StatelessWidget {
  final Function getImage;
  final Function camera;
  final File image;
  const UserAvatar({
    Key key,
    this.getImage,
    this.image,
    this.camera,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Stack(
        children: [
          ClipRect(
            child: Container(
              width: 100.0,
              height: 100.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
// borderRadius: BorderRadius.all(Radius.circular(50)),
                border: Border.all(color: Colors.white, width: 1),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: image != null
                      ? FileImage(image)
                      : AssetImage('images/person.png'),
                  // image: AssetImage('images/me.jpg'),
                ),
              ),
            ),
          ),
          Positioned(
            right: 10,
            left: 60,
            top: 80,
            child: FocusedMenuHolder(
                blurSize: 5.0,
                animateMenuItems: true,
                openWithTap: true,
                menuWidth: media.size.width * 0.50,
                menuItems: [
                  FocusedMenuItem(
                    title: Text('Camera'),
                    trailingIcon: Icon(Icons.camera_alt_rounded),
                    onPressed: camera,
                  ),
                  FocusedMenuItem(
                    title: Text('Gallery'),
                    trailingIcon: Icon(Icons.photo),
                    onPressed: getImage,
                  ),
                ],
                onPressed: () {},
                child: Icon(
                  Icons.camera_alt_rounded,
                  color: Theme.of(context).accentColor,
                  size: 26,
                )),
          ),
          // Positioned(
          //   bottom: 20,
          //   right: 10,
          //   top: 80,
          //   child: Icon(
          //     Icons.camera_alt_rounded,
          //     size: 26,
          //     color: Theme.of(context).accentColor,
          //   ),
          // )
        ],
      ),
    );
  }
}

// Container(
// height: 26,
// width: 26,
// child: Icon(
// Icons.camera_alt_rounded,
// size: 26,
// color: Theme.of(context).accentColor,
// ),
// ),
