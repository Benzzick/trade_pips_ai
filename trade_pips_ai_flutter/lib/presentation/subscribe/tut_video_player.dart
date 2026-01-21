import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TutVideoPlayer extends StatefulWidget {
  final String videoId;

  const TutVideoPlayer({
    super.key,
    required this.videoId,
  });

  @override
  State<TutVideoPlayer> createState() => _TutVideoPlayerState();
}

class _TutVideoPlayerState extends State<TutVideoPlayer> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        controlsVisibleAtStart: false,
        hideControls: true,
        loop: true,
        enableCaption: false,
        showLiveFullscreenButton: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: SizedBox(
        width: 364,
        height: 240,
        child: YoutubePlayer(
          controller: _controller,
          progressIndicatorColor: Colors.transparent,
          showVideoProgressIndicator: false,
          onReady: () async {
            _controller.play();
          },
        ),
      ),
    );
  }
}
