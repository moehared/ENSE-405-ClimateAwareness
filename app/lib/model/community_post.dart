// enum LinkType { Article, Media }

import 'package:cloud_firestore/cloud_firestore.dart';

class UserPost {
  final String uuid;
  final String title;
  final String desc;
  final String url;
  final String imageUrl;
  final String imagePath;
  final String type;
  final String user;
  String date;

  UserPost({
    this.user,
    this.uuid,
    this.title,
    this.desc,
    this.url,
    this.imageUrl,
    this.imagePath,
    this.type,
    this.date,
  });

  UserPost.fromJson(Map<String, dynamic> json)
      : user = json['user'],
        uuid = json['uuid'],
        title = json['title'],
        desc = json['desc'],
        url = json['url'],
        imageUrl = json['imageUrl'],
        imagePath = json['imagePath'],
        date = json['date'],
        type = json['type'];

  Map<String, dynamic> toJson() {
    return {
      'uuid': this.uuid,
      'title': this.title,
      'desc': this.desc,
      'imagePath': this.imagePath,
      'url': this.url,
      'type': this.type,
      'user': this.user,
      'imageUrl': this.imageUrl,
      'date': this.date = Timestamp.now().toDate().toLocal().toString(),
    };
  }
}
