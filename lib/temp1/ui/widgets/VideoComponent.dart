import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../global_constants.dart';

class VideoComponent extends StatefulWidget {


   VideoComponent({
    Key? key


  }) : super(key: key);


  @override
  State<VideoComponent> createState() => _VideoComponentState();
}



class _VideoComponentState extends State<VideoComponent> {
  late VideoPlayerController controller_video;
  @override
  void initState() {
    super.initState();
//
    controller_video = VideoPlayerController.network(
        videobar)
      ..initialize().then((_) {
        setState(() {});
      });
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          child: controller_video.value.isInitialized
              ? AspectRatio(
            aspectRatio: controller_video.value.aspectRatio,
            child: VideoPlayer(controller_video),
          )
              : Container(
            child: CircularProgressIndicator(),
          ),
        ),
        Positioned(
          bottom: 16.0,
          child: ElevatedButton(
            onPressed: () {
              // Button press logic
              setState(() {
                controller_video.value.isPlaying
                    ? controller_video.pause()
                    : controller_video.play();
              });

            },
            style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
            ),
            child:  Icon(
              controller_video.value.isPlaying ? Icons.pause : Icons.play_arrow,
            ),
          ),
        ),
      ],
    );
  }
}