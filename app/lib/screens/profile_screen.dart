import 'dart:io' show File, Platform;

import 'package:app/auth/auth_service.dart';
import 'package:app/model/personalize_tips.dart';
import 'package:app/screens/personalized_view_all_screen.dart';
import 'package:app/screens/questionaire_screen/questinaires_screen.dart';
import 'package:app/share_pref/local_data.dart';
import 'package:app/widget/result_chart.dart';
import 'package:app/widget/reusable_card.dart';
import 'package:app/widget/user_setting_menu.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/ProfileScreen';
  static const IMAGE_KEY = '/IMAGE_KEY';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var tipData = [];
  File _image;
  final imagePicker = ImagePicker();
  double res = 0.0;

  Future getGallery() async {
    final pickedFile = await imagePicker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      saveData(ProfileScreen.IMAGE_KEY, _image.path);
    } else {
      print('No image selected.');
    }
  }

  // final newList = tips.where((element) {
  //   if (element.userChoice == false) {
  //     return false;
  //   }
  //   return true;
  // });

  loadImage() async {
    final imageString = await getLocalData(ProfileScreen.IMAGE_KEY) ?? null;

    if (imageString != null) {
      setState(() {
        _image = File(imageString);
      });
    }
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
    _getTips();
    loadImage();
    super.initState();
  }

  _getTips() async {
    final res = await getLocalData(PersonalizedTip.TIPS_KEY) ?? null;
    if (res != null) {
      setState(() {
        tipData = res;
        // print('TIP data is $tipData\n');
        // tipData.forEach((element) {
        //   print('Retrieve data from json decode is ${element['type']}\n');
        // });
      });
    } else {
      print('Result retrieve is null\n');
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthService>(context, listen: false);
    final media = MediaQuery.of(context);
    final height = media.size.height;
    print('Height of ${Platform.isIOS ? 'Ios' : 'android'} is : $height');
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
          // color: Color(0xffc2185b).withAlpha(100),
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
              TitleAndButtonRow(
                title: 'Personalized Tips',
                viewAll: () {
                  Navigator.of(context).pushNamed(
                      PersonalizedViewAllScreen.PERSONALIZED_VIEW_ALL);
                },
              ),
              // categories,
              if (tipData.isNotEmpty)
                Container(
                  height: height >= 926 ? height * 0.15 : height * 0.20,
                  width: double.infinity,
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (ctx, index) {
                      // var data = tipData.elementAt(index).values.toList();
                      var data = tipData[index];
                      // var data = tipData.elementAt(index);
                      // var data = newList.elementAt(index);
                      return ReusableCard(
                        // id: data.id,
                        // imageAsset: data.image,
                        // subTitle: data.subTitle,
                        id: data['id'],
                        imageAsset: data['image'],
                        subTitle: data['subtitle'],
                      );
                    },
                    itemCount: tipData.length,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              if (tipData.isEmpty)
                Center(
                  child: Text(
                      'No personalized tips yet. start answering questionnaires'),
                ),
              SizedBox(height: 5),
              Divider(color: Colors.black26),
              TitleAndButtonRow(
                title: 'Achievement',
                viewAll: () {},
              ),
              Text('under construction'),
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
      builder: (_) => UserMenuPopUp(
        isEdit: false,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
    );
  }
}

class TitleAndButtonRow extends StatelessWidget {
  final String title;
  final Function viewAll;

  const TitleAndButtonRow({Key key, this.title, this.viewAll})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
          child: Text(
            title,
            style: TextStyle(
              fontFamily: 'Roboto-Medium',
              color: Colors.white,
            ),
          ),
        ),
        TextButton(
          onPressed: viewAll,
          child: Text(
            'View All',
            style: TextStyle(
              color: Theme.of(context).accentColor,
            ),
          ),
        ),
      ],
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
