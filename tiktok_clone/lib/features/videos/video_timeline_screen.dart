import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class VideoTimeLineScreen extends StatefulWidget {
  const VideoTimeLineScreen({super.key});

  @override
  State<VideoTimeLineScreen> createState() => _VideoTimeLineScreenState();
}

class _VideoTimeLineScreenState extends State<VideoTimeLineScreen> {
  int _itemCount = 4;

  List<Color> colors = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.yellow,
  ];

  void _onPageChanged(int page) {
    //print(page); 출력 페이지 참고.
    if (page == _itemCount - 1) {
      _itemCount = _itemCount + 5;
      colors.addAll([
        Colors.teal,
        Colors.blue,
        Colors.red,
        Colors.green,
        Colors.yellow,
      ]);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      // builder을 사용하면 스크롤 할때 데이터를 불러온다.
      //pageSnapping: false, // 자동으로 안넘어가게.
      scrollDirection: Axis.vertical, // 세로 방향 스크롤
      onPageChanged: _onPageChanged,
      itemCount: _itemCount,
      itemBuilder: (context, index) => Container(
        color: colors[index],
        child: Center(
          child: Text(
            "Screen $index",
            style: const TextStyle(fontSize: Sizes.size64),
          ),
        ),
      ), //builder의 필수 파라메터.
    );
    //여기서 scaffold를 쓰지 않아도 되는 이유.
    // 이것을 사용 하는 곳이, scaffold 안에 있기 때문.
  }
}
