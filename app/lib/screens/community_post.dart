import 'dart:io' show File, Platform;

import 'package:app/auth/auth_service.dart';
import 'package:app/constant.dart';
import 'package:app/model/community_post.dart';
import 'package:app/pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:youtube_video_validator/youtube_video_validator.dart';

class AddPostScreen extends StatefulWidget {
  static const String RouteName = '/AddPostScreen';
  // final Stream<UserPost> userEditPost;
  // final Map<String, dynamic> userEditPost;
  final List<String> userEditPost;

  AddPostScreen({this.userEditPost});

  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  var urlPattern =
      r"(https?|http)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?";
  var _descNode = FocusNode();
  var _titleNode = FocusNode();
  var id;
  var _imageUrlController;
  var _linkUrlController;
  // var _imageUrlController = TextEditingController();
  // var _linkUrlController = TextEditingController();
  var selectedType = "select article type";
  final imagePicker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  var _imageURL = "";
  var isValidImageURL = true;
  var error = false;
  var isErrorURL = false;
  var isMediaError = false;

  var userPost = UserPost(
      type: null,
      desc: "",
      title: "",
      imagePath: "",
      imageUrl: "",
      url: "",
      user: null,
      uuid: "");

  File _image;
  var isUserUpload = false;
  var validateURLImage = false;
  var editDesc = "";
  var editTitle = "";

  DropdownButton<String> androidDropDown() {
    List<DropdownMenuItem<String>> item = [];
    for (String type in dropDownList) {
      var menu = DropdownMenuItem(
        value: type,
        child: Text(type),
      );
      item.add(menu);
    }

    return DropdownButton(
        hint: Text(selectedType),
        items: item,
        onChanged: (val) {
          setState(() {
            selectedType = val;
          });
          if (selectedType == 'article') {
            print('selectedType is $selectedType\n');
            userPost = UserPost(
              uuid: userPost.uuid,
              user: userPost.user,
              url: userPost.url,
              imageUrl: userPost.imageUrl,
              imagePath: userPost.imagePath,
              title: userPost.title,
              desc: userPost.desc,
              type: ARTICLE,
            );
          }
          if (selectedType == 'media') {
            print('selectedType is $selectedType\n');
            userPost = UserPost(
              uuid: userPost.uuid,
              user: userPost.user,
              url: userPost.url,
              imageUrl: userPost.imageUrl,
              imagePath: userPost.imagePath,
              title: userPost.title,
              desc: userPost.desc,
              type: MEDIA,
            );
          }
        });
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String type in dropDownList) {
      pickerItems.add(Text(type));
    }

    return CupertinoPicker(
      itemExtent: 40.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedType = dropDownList[selectedIndex];
          print(selectedType);
        });
      },
      children: pickerItems,
    );
  }

  @override
  void initState() {
    super.initState();
    print("init state\n");
    _getEditPostData();
  }

  void _getEditPostData() {
    if (widget.userEditPost.isNotEmpty) {
      print('inside edit post and if statment\n');
      setState(() {
        _imageUrlController =
            TextEditingController(text: widget.userEditPost[4]);
        _linkUrlController =
            TextEditingController(text: widget.userEditPost[0]);
        _image = File(widget.userEditPost[5]);
        editTitle = widget.userEditPost[1];
        print('edit title is $editTitle\n');
        editDesc = widget.userEditPost[2];
        selectedType = widget.userEditPost[3];
        id = widget.userEditPost[6];
        print(
            "link url: ${_linkUrlController.text}\n image url : ${_imageUrlController.text}\n doc id is : $id");
      });
    } else {
      print("else statement. no edit post detected\n");
      setState(() {
        _imageUrlController = TextEditingController();
        _linkUrlController = TextEditingController();
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _descNode.dispose();
    _imageUrlController.dispose();
    _titleNode.dispose();
    _linkUrlController.dispose();
  }

  Future getGallery() async {
    final pickedFile = await imagePicker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        // print('image file is ${pickedFile.path}\n');
        isUserUpload = true;
        _imageUrlController.clear();
      });
      // saveData(ProfileScreen.IMAGE_KEY, _image.path);
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    // _imageUrlController.text ;
    //https: //images.unsplash.com/photo-1541963463532-d68292c34b19?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxleHBsb3JlLWZlZWR8M3x8fGVufDB8fHw%3D&w=1000&q=80
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.userEditPost.isEmpty ? 'add post' : 'edit your post'),
        leading: IconButton(
            icon:
                Icon(Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop(false);
            }),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  // initialValue: _linkUrlController.text.isNotEmpty
                  //     ? _linkUrlController.text
                  //     : "enter link",
                  controller: _linkUrlController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: 'Link URL'),
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_titleNode);
                  },
                  validator: (String link) {
                    var match = new RegExp(urlPattern, caseSensitive: false)
                        .firstMatch(link);
                    // validMedia(link);
                    if (link.isEmpty) {
                      return 'Enter Link';
                    } else if (match == null ||
                        (isErrorURL && _linkUrlController.text.isNotEmpty)) {
                      return 'invalid url link';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (url) {
                    checkURL(url);
                  },
                  onSaved: (link) {
                    // checkURL(link);
                    // validMedia(link);
                    if (isErrorURL == false) {
                      userPost = UserPost(
                        uuid: userPost.uuid,
                        user: userPost.user,
                        url: link,
                        imageUrl: userPost.imageUrl,
                        imagePath: userPost.imagePath,
                        title: userPost.title,
                        desc: userPost.desc,
                        type: userPost.type,
                      );
                    }

                    // bool isValid = YoutubeVideoValidator.validateUrl(link);
                    // print('is valid = $isValid\n');
                  },
                ),
                if (isMediaError)
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'please make sure the link corresponds to the type of content',
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.red[900]),
                    ),
                  ),
                TextFormField(
                  initialValue: editTitle.isNotEmpty ? editTitle : "",
                  focusNode: _titleNode,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: 'title'),
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_descNode);
                  },
                  validator: (String title) {
                    if (title.isEmpty) {
                      return 'Enter title';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (title) {
                    userPost = UserPost(
                      uuid: userPost.uuid,
                      user: userPost.user,
                      url: userPost.url,
                      imageUrl: userPost.imageUrl,
                      imagePath: userPost.imagePath,
                      title: title,
                      desc: userPost.desc,
                      type: userPost.type,
                    );
                  },
                ),
                TextFormField(
                  initialValue: editDesc.isNotEmpty ? editDesc : "",
                  focusNode: _descNode,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  maxLines: 2,
                  decoration: InputDecoration(labelText: 'description'),
                  validator: (String desc) {
                    if (desc.isEmpty) {
                      return 'Enter short description';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (desc) {
                    userPost = UserPost(
                        uuid: userPost.uuid,
                        user: userPost.user,
                        url: userPost.url,
                        imageUrl: userPost.imageUrl,
                        imagePath: userPost.imagePath,
                        title: userPost.title,
                        desc: desc,
                        type: userPost.type);
                  },
                ),
                SizedBox(height: 20),
                Container(
                  // padding: EdgeInsets.only(bottom: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Type of content'),
                      SizedBox(height: 20),
                      Platform.isIOS ? iOSPicker() : androidDropDown(),
                    ],
                  ),
                ),
                if (error)
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'select type of article',
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.red[900]),
                    ),
                  )
                else
                  Container(),
                SizedBox(height: 20),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // _image != null && _imageUrlController.text.isEmpty
                    if (isUserUpload)
                      Container(
                        width: 100.0,
                        height: 100.0,
                        margin: EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: _image != null
                                  ? FileImage(_image)
                                  : Text(
                                      'Enter URL or upload image from your phone')
                              // image: AssetImage('images/me.jpg'),
                              ),
                        ),
                      ),
                    // _image == null && _imageUrlController.text.isNotEmpty
                    if (isUserUpload == false)
                      Container(
                        width: 100,
                        height: 100,
                        margin: EdgeInsets.only(top: 8, right: 10),
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                        ),
                        child: _imageUrlController.text.isEmpty
                            ? Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Text(
                                    'Enter URL or upload image from your phone'),
                              )
                            : Image.network(
                                _imageUrlController.text,
                                fit: BoxFit.cover,
                              ),
                      ),
                    Expanded(
                      child: TextFormField(
                        controller: _imageUrlController,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.url,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).unfocus();
                        },
                        validator: (url) {
                          validateImageURL();
                          if (validateURLImage == false &&
                              isUserUpload == false) {
                            return 'invalid Image Url';
                          } else if (isValidImageURL == false) {
                            return "not correct format image";
                          } else {
                            return null;
                          }
                        },
                        onSaved: (imageUrl) {
                          setState(() {
                            _imageURL = imageUrl;
                          });
                        },
                        decoration: InputDecoration(labelText: 'Image URL'),
                        onEditingComplete: () {
                          // print('Image url is ${_imageUrlController.text}');
                          setState(() {
                            isUserUpload = false;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: getGallery,
                      child: Text(
                        'upload image',
                        style: TextStyle(color: Theme.of(context).accentColor),
                      )),
                ),
                SizedBox(height: 30),
                Container(
                  margin: EdgeInsets.all(20),
                  height: 40,
                  decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  width: double.infinity,
                  child: TextButton(
                    onPressed: _submit,
                    child: Text(
                      'post',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submit() {
    print('submitted tapped inside submit button \n');
    final user = Provider.of<AuthService>(context, listen: false);
    bool validate = _formKey.currentState.validate();
    if (!validate) {
      return;
    }

    _formKey.currentState.save();
    validMedia(_linkUrlController.text);

    if (selectedType != 'select article type' &&
        isErrorURL == false &&
        isMediaError == false) {
      validMedia(_linkUrlController.text);
      print('valid url\n');
      if (isUserUpload == false) {
        if ((_imageUrlController.text.isNotEmpty || _imageURL.isNotEmpty) &&
            widget.userEditPost.isEmpty) {
          print('user image url is $_imageURL');
          userPost = UserPost(
            uuid: Uuid().v4(),
            user: user.currentUser.uid,
            url: userPost.url,
            imageUrl: _imageURL,
            imagePath: "",
            title: userPost.title,
            desc: userPost.desc,
            type: userPost.type,
          );
          user.savePost(userPost);
        } else {
          userPost = UserPost(
            type: selectedType,
            desc: editDesc,
            title: editTitle,
            imagePath: _image.path,
            imageUrl: _imageUrlController.text,
            url: _linkUrlController.text,
          );
          _formKey.currentState.save();
          user.updatePost(userPost, id);
          print('data is updated\n');
        }
        print(
            'link: ${userPost.url}\ntitle: ${userPost.title}\ndesc: ${userPost.desc}\n'
            'type: ${userPost.type}\nimageURL: ${userPost.imageUrl}\n'
            'image path: ${userPost.imagePath}\nuser: ${userPost.user}\nuuid: ${userPost.uuid}\n');
        print('\n');
        // userRef.child('link_post').push().set(userPost.toJson());

        print('data is saved\n');
      } else {
        // print('user choice is $isUserUpload');
        if (_image != null && widget.userEditPost.isEmpty) {
          userPost = UserPost(
            uuid: Uuid().v4(),
            user: user.currentUser.uid,
            url: userPost.url,
            imageUrl: "",
            imagePath: _image.path,
            title: userPost.title,
            desc: userPost.desc,
            type: userPost.type,
          );
          _imageUrlController.clear();
          print('cleared');
          print(
              'link: ${userPost.url}\ntitle: ${userPost.title}\ndesc: ${userPost.desc}\n'
              'type: ${userPost.type}\nimageURL: ${userPost.imageUrl}\n'
              'image path: ${userPost.imagePath}\nuser: ${userPost.user}\nuuid: ${userPost.uuid}\n');

          user.savePost(userPost);
          print('data is saved\n');
        } else {
          userPost = UserPost(
            type: selectedType,
            desc: editDesc,
            title: editTitle,
            imagePath: _image.path,
            imageUrl: _imageUrlController.text,
            url: _linkUrlController.text,
          );
          _formKey.currentState.save();
          user.updatePost(userPost, id);
          print('data is updated\n');
        }
      }
      if (!mounted) {
        return;
      } else {
        Navigator.of(context).pop();
      }
    } else {
      if (isErrorURL) {
        setState(() {
          isErrorURL = true;
        });
        checkURL(_linkUrlController.text);
      } else if (isMediaError) {
        setState(() {
          isMediaError = true;
        });
        validMedia(_linkUrlController.text);
      } else {
        setState(() {
          error = true;
        });
      }
    }
  }

  void checkURL(String url) async {
    var noImage = false;
    var response;
    if (url.isNotEmpty) {
      response = await http.head(url);
      // match = new RegExp(urlPattern, caseSensitive: false)
      //     .firstMatch(_linkUrlController.text);
      noImage = url.contains(".jpg") || url.contains(".png");
    }

    if (response != null) {
      if (response.statusCode == 200) {
        setState(() {
          isErrorURL = false;
        });
        print('url is good\n');
      } else {
        setState(() {
          isErrorURL = true;
        });
        print('error happened error value is $isErrorURL\n');
      }
    } else {
      print('url is empty');
    }

    if (noImage) {
      setState(() {
        isErrorURL = true;
      });
    }
  }

  void validateImageURL() async {
    var response;

    if (_imageUrlController.text.isNotEmpty) {
      response = await http.head(_imageUrlController.text);
      if (mounted) {
        setState(() {
          isValidImageURL = _imageUrlController.text.contains("jpg") ||
              _imageUrlController.text.contains("png");
        });
      }
      if (response.statusCode == 200) {
        if (mounted) {
          setState(() {
            validateURLImage = true;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            validateURLImage = false;
          });
        }
      }
    }
  }

  void validMedia(String link) {
    print('selected type inside valid media is $selectedType\n');
    if (link.isNotEmpty) {
      if (YoutubeVideoValidator.validateUrl(link) &&
          selectedType.toLowerCase() != MEDIA.toLowerCase()) {
        setState(() {
          isMediaError = true;
        });
        print(' youtube is valid but not selected type is $selectedType\n');
      }
      if (!YoutubeVideoValidator.validateUrl(link) &&
          selectedType.toLowerCase() == MEDIA.toLowerCase()) {
        setState(() {
          isMediaError = true;
        });
        print(' youtube is not valid but selected is $selectedType\n');
      }

      if (YoutubeVideoValidator.validateUrl(link) &&
          selectedType.toLowerCase() == MEDIA.toLowerCase()) {
        setState(() {
          isMediaError = false;
        });
        print(' youtube is valid and selected is $selectedType\n');
      }

      if (!YoutubeVideoValidator.validateUrl(link) &&
          selectedType.toLowerCase() == ARTICLE.toLowerCase()) {
        setState(() {
          isMediaError = false;
        });
        print(' youtube is not valid and selected is $selectedType\n');
      }
    }
  }
}

//
// else if (match == null) {
// setState(() {
// isErrorURL = true;
// });
// print('match is null $isErrorURL\n');
// }
