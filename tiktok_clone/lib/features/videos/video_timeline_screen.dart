import 'package:flutter/material.dart';
import 'package:tiktok_clone/features/videos/widgets/video_post.dart';

class VideoTimeLineScreen extends StatefulWidget {
  const VideoTimeLineScreen({super.key});

  // const VideoTimeLineScreen({super.key});

  @override
  State<VideoTimeLineScreen> createState() => _VideoTimeLineScreenState();
}

class _VideoTimeLineScreenState extends State<VideoTimeLineScreen> {
  int _itemCount = 4;

  final PageController _pageController = PageController();

  final Duration _scrollDuration = const Duration(milliseconds: 250);
  final Curve _scrollCurve = Curves.linear;

  // List<Color> colors = [
  //   Colors.blue,
  //   Colors.red,
  //   Colors.green,
  //   Colors.yellow,
  // ];

  void _onPageChanged(int page) {
    //print(page); 출력 페이지 참고.
    _pageController.animateToPage(
      // 위치가 여깄는 이유는, 이 애니메이션의 종류와 길이를 모든 화면에 적용하고자 하기 때문.
      page,
      duration: _scrollDuration,
      curve: _scrollCurve,
    );
    if (page == _itemCount - 1) {
      _itemCount = _itemCount + 5;
      // colors.addAll([
      //   Colors.teal,
      //   Colors.blue,
      //   Colors.red,
      //   Colors.green,
      //   Colors.yellow,
      // ]);
      setState(() {});
    }
  }

  void _onvideoFinished() {
    return;
    // _pageController.nextPage(
    //   duration: _scrollDuration,
    //   curve: _scrollCurve,
    // );
    // 다음으로 자동으로 넘어가게 하는 방법.
  }

  // @override
  // void dispose() {
  //   _pageController.nextPage(
  //     duration: _scrollDuration,
  //     curve: _scrollCurve,
  //   );
  //   super.dispose();
  // }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

// 위아래로 그냥 동영상 바꿀때는 이렇게.
  // @override
  // Widget build(BuildContext context) {
  //   return PageView.builder(
  //     controller: _pageController,
  //     // builder을 사용하면 스크롤 할때 데이터를 불러온다.
  //     //pageSnapping: false, // 자동으로 안넘어가게.
  //     scrollDirection: Axis.vertical, // 세로 방향 스크롤
  //     onPageChanged: _onPageChanged,
  //     itemCount: _itemCount,
  //     itemBuilder: (context, index) => VideoPost(
  //       onvideoFinished: _onvideoFinished,
  //       index: index,
  //     ),
  //     // Container(
  //     //   color: colors[index],
  //     //   child: Center(
  //     //     child: Text(
  //     //       "Screen $index",
  //     //       style: const TextStyle(fontSize: Sizes.size64),
  //     //     ),
  //     //   ),
  //     // ), //builder의 필수 파라메터.
  //   );
  //   //여기서 scaffold를 쓰지 않아도 되는 이유.
  //   // 이것을 사용 하는 곳이, scaffold 안에 있기 때문.
  // }

  // 이거는 화면을 알래로 당겨서 새로 고침 하는 화면.

  Future<void> _onRefresh() {
    return Future.delayed(const Duration(
      seconds: 5,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      displacement: 100, // 새로 고침 아이콘이 돌아가는 위치
      edgeOffset: 200, // 새로 고침 아이콘이 나타나는 위치
      //backgroundColor: Colors.red,// 아이콘 배경 색.
      color: Theme.of(context).primaryColor, // 화살표 색깔.
      // strokeWidth: 10, // 화살표 두께.
      // 이때 새로고침 하기위해 당기는 화면의 뒤쪽 색깔이 화이트 인데, 이건 main_navigation_screen의 기본 컬러가 화이트 색이기 떄문이다.
      onRefresh: _onRefresh,
      child: PageView.builder(
        controller: _pageController,
        // builder을 사용하면 스크롤 할때 데이터를 불러온다.
        //pageSnapping: false, // 자동으로 안넘어가게.
        scrollDirection: Axis.vertical, // 세로 방향 스크롤
        onPageChanged: _onPageChanged,
        itemCount: _itemCount,
        itemBuilder: (context, index) => VideoPost(
          onvideoFinished: _onvideoFinished,
          index: index,
        ),
        // Container(
        //   color: colors[index],
        //   child: Center(
        //     child: Text(
        //       "Screen $index",
        //       style: const TextStyle(fontSize: Sizes.size64),
        //     ),
        //   ),
        // ), //builder의 필수 파라메터.
      ),
    );
    //여기서 scaffold를 쓰지 않아도 되는 이유.
    // 이것을 사용 하는 곳이, scaffold 안에 있기 때문.
  }
}
