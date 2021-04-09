import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PLayYoutubeVideo extends StatelessWidget {
  static const String routeName = '/PLayYoutubeVideo';
  final List<String> data;

  PLayYoutubeVideo(this.data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data[0]),
      ),
      body: Column(
        children: [
          Expanded(
            child: YoutubePlayerBuilder(
              // onEnterFullScreen: () {
              //   SystemChrome.setPreferredOrientations(DeviceOrientation.values);
              // },
              builder: (ctx, player) {
                return player;
              },
              onExitFullScreen: () {
                SystemChrome.setPreferredOrientations(DeviceOrientation.values);
              },
              player: YoutubePlayer(
                showVideoProgressIndicator: true,
                progressIndicatorColor: Colors.blue,
                progressColors: ProgressBarColors(
                    playedColor: Theme.of(context).accentColor),
                controller: YoutubePlayerController(
                  initialVideoId: YoutubePlayer.convertUrlToId(data[1]),
                  flags: YoutubePlayerFlags(
                    isLive: false,
                    autoPlay: true,
                    enableCaption: false,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
