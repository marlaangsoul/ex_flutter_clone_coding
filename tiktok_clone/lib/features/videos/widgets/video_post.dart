import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/videos/widgets/video_button.dart';
import 'package:tiktok_clone/features/videos/widgets/video_comments.dart';
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

class _VideoPostState extends State<VideoPost>
    with SingleTickerProviderStateMixin
// with 키워드에 Mixin을 사용하면, 그 클래스를 복사해 오겠다는 뜻.
// 그 클래스의 메서드와 속성을 전부 가져오는 것.
// 위젯이 보일 때만 Ticker를 제공해 준다는 것.
{
  // 작업은 State에서 한다.
  final VideoPlayerController _videoPlayerController =
      VideoPlayerController.asset("assets/videos/video.mp4");

  bool _isPaused = false;

  final Duration _animationDuration = const Duration(milliseconds: 200);

  late final AnimationController _animationController;

  void _onVideoChange() {
    if (_videoPlayerController.value.duration ==
        _videoPlayerController.value.position) {
      widget.onvideoFinished();
    }
  }

  void _initVideoPlayer() async {
    await _videoPlayerController.initialize(); //1단계 초기화.
    //_videoPlayerController.play(); //2단계 플레이.
    await _videoPlayerController.setLooping(true);
    _videoPlayerController.addListener(_onVideoChange);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();

    _animationController = AnimationController(
      vsync: this, // with SingleTickerProviderStateMixin 가 필수로 필요.
      // offscreen 애니메이션의 불필요한 리소스를 방지하는 것.
      // 위젯이 안 보일 떄는 애니메이션이 작동하지 않게 하는 것.
      // this는 자기자신이 속한 클래스.
      lowerBound: 1.0,
      upperBound: 1.5,
      value: 1.5, // 시작 value
      duration: _animationDuration,
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction == 1 &&
        !_isPaused &&
        !_videoPlayerController.value.isPlaying) {
      _videoPlayerController.play();
    }
    // 첫번째 결함은 이 부분 때문.
    // 영상의 visibilit가 변하고 영상이 전부 화면에 들어가 있으면 재생이 안되면, 재생 시켜주는 조건.
  }

  void _onTogglePause() {
    // 정지.
    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
      _animationController.reverse();
      //_animationController.reset();
    } else {
      _videoPlayerController.play();
      _animationController.forward();
    }
    setState(() {
      _isPaused = !_isPaused;
    });
  }

  // 코멘트 버튼(댓글)
  void _onCommentsTap(BuildContext context) async {
    //showmodalbottomSheet가 나올때 일시정시 되도록
    if (_videoPlayerController.value.isPlaying) {
      _onTogglePause();
    }
    // 바닥에서 올라오는 모달창
    // 이렇 게 아주 쉽게 만들 수 있다.
    await showModalBottomSheet(
      context: context,
      isScrollControlled:
          true, // 이렇게 하면 bottom sheet의 사이즈를 final size = MediaQuery.of(context).size; 이걸로 바꿀수 있다.
      // barrierColor: Colors.red, // 바텀에서 올라오는 모달 창 을 제외한 나머지 컬러.
      backgroundColor: Colors.transparent, // Scaffold의 색으로 표현.
      builder: (context) => const VideoComments(),
    );
    print('async 와 await를 찍으면 사용자가 다시 화면으로 돌아간 것을 알 수 있다.');
    _onTogglePause();
  }

  @override
  Widget build(BuildContext context) {
    // print(_animationController.value);
    return VisibilityDetector(
      // 버그 1.첫번째 화면에서 화면을 정지하고 새로고침 하면 정지된 것도 재생이 된다.
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
          Positioned.fill(
            child: IgnorePointer(
              // 아이콘에 보내는 신호를 무시.
              // Position을 감싸면 안된다. Position은 언제나 Stack의 child 여야 한다.
              child: Center(
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    // builder 함수인데, _animationController 의 값이 변할 때마다 실행된다.
                    // setState로 전제 빌더를 재 실행 하는 것과는 다르게, 아래 이부분만 재실행 하는 애니메이션 빌더인 것이다.
                    return Transform.scale(
                      scale: _animationController.value,
                      child: child,
                    );
                  },
                  child: AnimatedOpacity(
                    opacity: _isPaused ? 1 : 0,
                    duration: _animationDuration,
                    child: const FaIcon(
                      FontAwesomeIcons.play,
                      color: Colors.white,
                      size: Sizes.size72,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
              bottom: 30,
              left: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    '@marlaangsoul',
                    style: TextStyle(
                      fontSize: Sizes.size20,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Gaps.v20,
                  Text(
                    'This is my Car',
                    style: TextStyle(
                      fontSize: Sizes.size14,
                      color: Colors.white,
                      fontWeight: FontWeight.w200,
                    ),
                  )
                ],
              )),
          Positioned(
              bottom: 20,
              right: 10,
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.red,
                    foregroundImage: NetworkImage(
                        "https://avatars.githubusercontent.com/u/101851921?v=4"),
                    child: Text("BH"),
                  ),
                  Gaps.v16,
                  const VideoButton(
                    icon: FontAwesomeIcons.solidHeart,
                    text: "2.9M",
                  ),
                  Gaps.v16,
                  GestureDetector(
                    onTap: () => _onCommentsTap(context),
                    child: const VideoButton(
                      icon: FontAwesomeIcons.solidComment,
                      text: "33K",
                    ),
                  ),
                  Gaps.v16,
                  const VideoButton(
                    icon: FontAwesomeIcons.share,
                    text: "Share",
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
