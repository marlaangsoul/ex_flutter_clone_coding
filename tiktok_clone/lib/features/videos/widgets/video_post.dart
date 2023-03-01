import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPost extends StatefulWidget {
  final Function onvideoFinished; //statefulwidget의 property를 state에서 어떻게 접근할까?
  // 정답은 widget. 하면 된다.

  final int index;

  const VideoPost({
    //   super.key,
    //   required this.onvideoFinished,
    // });
    Key? key,
    required this.onvideoFinished,
    required this.index,
  }) : super(key: key);

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
    //_videoPlayerController.play(); //2단계 플레이.
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

  void _onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction == 1 && !_videoPlayerController.value.isPlaying) {
      _videoPlayerController.play();
    }
  }

  void _onTogglePause() {
    // 정지.
    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
    } else {
      _videoPlayerController.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key("${widget.index}"),
      onVisibilityChanged: _onVisibilityChanged,
      child: Stack(
        children: [
          Positioned.fill(
            child: _videoPlayerController.value.isInitialized
                ? VideoPlayer(_videoPlayerController)
                : Container(
                    color: Colors.black,
                  ),
            // _videoPlayerController의 값이 초기화 되었다면, 컨테이너를 보여주지 말고, 비디오 플레이어 위젯을 보여줘. 하지만 그게 안됬으면, 블랙 화면을 보여줘.
          ),
          Positioned.fill(
            child: GestureDetector(
              onTap: _onTogglePause,
            ),
          ),
          const Positioned.fill(
            child: IgnorePointer(
              // 아이콘에 보내는 신호를 무시.
              // Position을 감싸면 안된다. Position은 언제나 Stack의 child 여야 한다.
              child: Center(
                child: FaIcon(
                  FontAwesomeIcons.play,
                  color: Colors.white,
                  size: Sizes.size72,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
