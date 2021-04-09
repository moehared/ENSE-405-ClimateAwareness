import 'dart:io';

import 'package:app/constant.dart';
import 'package:app/model/community_post.dart';
import 'package:app/screens/play_youtube_player.dart';
import 'package:app/widget/user_setting_menu.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_video_validator/youtube_video_validator.dart';

class ReusablePostCard extends StatelessWidget {
  final UserPost post;
  final String id;
  final String uuid;

  const ReusablePostCard({
    this.post,
    this.id,
    this.uuid,
  });

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              child: Text(
                post.type ?? "no data",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ),
            // Container(
            //   height: 30,
            //   margin: const EdgeInsets.all(10),
            //   decoration: BoxDecoration(
            //       // color: Theme.of(context).accentColor.withAlpha(100),
            //       // borderRadius: BorderRadius.circular(5.0),
            //       border: Border.all(color: Colors.white, width: 1)),
            TextButton(
              style: TextButton.styleFrom(padding: EdgeInsets.all(5)),
              onPressed: () => _edit(context),
              child: Text(
                'edit',
                style: TextStyle(
                  fontSize: 18,
                  // fontWeight: FontWeight.w900,
                  fontFamily: 'Roboto-Regular',
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
            ),
            // )
          ],
        ),
        Container(
          height: media.height * 0.25,
          // padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.purple,
            borderRadius: const BorderRadius.all(
              Radius.circular(32),
            ),
          ),
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(32),
                ),
                child: post.imageUrl.isNotEmpty
                    ? Image.network(
                        post.imageUrl,
                        width: double.infinity,
                        height: media.height * 0.4,
                        fit: BoxFit.cover,
                      )
                    : Image.file(
                        File(post.imagePath),
                        width: double.infinity,
                        height: media.height * 0.4,
                        fit: BoxFit.cover,
                      ),
              ),
              Positioned(
                bottom: 20,
                // right: 10,
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return Container(
                      color: Colors.black54,
                      width: media.width * 0.60,
                      margin: const EdgeInsets.only(left: 5.0),
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5),
                      child: Text(
                        post.desc,
                        style: TextStyle(
                          fontSize: 24.0,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                bottom: 20,
                right: 10,
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  child: TextButton(
                    child: Text(
                      post.type == ARTICLE ? 'read' : 'watch',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      _links(context);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _links(context) async {
    if (YoutubeVideoValidator.validateUrl(post.url)) {
      Navigator.of(context).pushNamed(PLayYoutubeVideo.routeName,
          arguments: [post.title, post.url]);
    } else {
      if (await canLaunch(post.url)) {
        print('launching...\n');
        await launch(post.url);
      } else {
        throw 'Could not launch ${post.url}\n';
      }
    }
  }

  void _edit(context) {
    showModalBottomSheet(
        context: context,
        builder: (_) => UserMenuPopUp(
              id: id,
              isEdit: true,
              uuid: uuid,
            ));
  }
}
