import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectIndex = 0;

  final screens = [
    const Center(
      child: Text("Home"),
    ),
    const Center(
      child: Text("Search"),
    ),
  ];

  void _onTap(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    //아이폰 스타일의 네이티브 바. (그런데 그런 네츄럴한 느낌은 안난다.)
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const [
          BottomNavigationBarItem(
              icon: FaIcon(CupertinoIcons.house), label: "Home"),
          BottomNavigationBarItem(
              icon: FaIcon(CupertinoIcons.search), label: "Search"),
        ],
      ), //
      tabBuilder: (context, index) => screens[index], // 이건 위젯을 반환해야하는 펄션.
      // 펑션 2가지는 빌드 컨택스트와 인트
    );
  }
}
