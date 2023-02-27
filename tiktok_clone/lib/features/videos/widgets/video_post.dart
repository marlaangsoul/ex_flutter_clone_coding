import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPost extends StatefulWidget {
  final Function onvideoFinished; //statefulwidget의 property를 state에서 어떻게 접근할까?
  // 정답은 widget. 하면 된다.

  const VideoPost({
    super.key,
    required this.onvideoFinished,
  });

  @override
  State<VideoPost> createState() => _VideoPostState();
}

class _VideoPostState extends State<VideoPost> {
  // 작업은 State에서 한다.
  final VideoPlayerController _videoPlayerController =
      VideoPlayerController.asset("assets/videos/video.mp4");

  void _onVideoChange() {
    if (_videoPlayerController.value.duration ==
        _videoPlayerController.value.position) {
      widget.onvideoFinished();
    }
  }

  void _initVideoPlayer() async {
    await _videoPlayerController.initialize(); //1단계 초기화.
    _videoPlayerController.play(); //2단계 플레이.
    setState(() {});
    _videoPlayerController.addListener(_onVideoChange);
  }

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: _videoPlayerController.value.isInitialized
              ? VideoPlayer(_videoPlayerController)
              : Container(
                  color: Colors.black,
                ),
          // _videoPlayerController의 값이 초기화 되었다면, 컨테이너를 보여주지 말고, 비디오 플레이어 위젯을 보여줘. 하지만 그게 안됬으면, 블랙 화면을 보여줘.
        ),
      ],
    );
  }
}
