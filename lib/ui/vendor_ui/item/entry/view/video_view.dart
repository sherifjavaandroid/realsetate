import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../../../config/ps_colors.dart';
import '../../../../../core/vendor/constant/ps_dimens.dart';

class PlayerVideoView extends StatefulWidget {
  const PlayerVideoView(this.videoPath);
  final String videoPath;
  @override
  PlayerVideoAndPopPageState<PlayerVideoView> createState() =>
      PlayerVideoAndPopPageState<PlayerVideoView>();
}

class PlayerVideoAndPopPageState<T extends PlayerVideoView>
    extends State<PlayerVideoView> {
  VideoPlayerController? _videoPlayerController;
  bool startedPlaying = false;

  @override
  void initState() {
    super.initState();

    _videoPlayerController = VideoPlayerController.file(File(widget.videoPath));
    // _videoPlayerController!.addListener(() {
    //   if (startedPlaying && !_videoPlayerController!.value.isPlaying) {
    //     Navigator.pop(context);
    //   }
    // });
  }

  @override
  void dispose() {
    _videoPlayerController!.dispose();
    super.dispose();
  }

  Future<bool> started() async {
    await _videoPlayerController!.initialize();
    await _videoPlayerController!.play();
    startedPlaying = true;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    /**
     * UI SECTION
     */
    return Stack(
      children: <Widget>[
        Material(
          elevation: 0,
          child: Center(
            child: FutureBuilder<bool>(
              future: started(),
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                if (snapshot.data == true) {
                  return AspectRatio(
                    aspectRatio: _videoPlayerController!.value.aspectRatio,
                    child: VideoPlayer(_videoPlayerController!),
                  );
                } else {
                  return const Text('waiting for video to load');
                }
              },
            ),
          ),
        ),
        Positioned(
            left: PsDimens.space16,
            top: Platform.isIOS ? PsDimens.space60 : PsDimens.space40,
            child: GestureDetector(
              child: Container(
                  width: 50,
                  height: 50,
                  child: Icon(Icons.clear, color: PsColors.achromatic900)),
              onTap: () {
                Navigator.pop(context);
              },
            )),
      ],
    );
  }
}
