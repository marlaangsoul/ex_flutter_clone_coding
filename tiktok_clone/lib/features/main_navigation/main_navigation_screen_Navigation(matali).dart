import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainNavigationScreenM extends StatefulWidget {
  const MainNavigationScreenM({super.key});

  @override
  State<MainNavigationScreenM> createState() => _MainNavigationMScreenState();
}

class _MainNavigationMScreenState extends State<MainNavigationScreenM> {
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
    return Scaffold(
      body: screens[_selectIndex],
      bottomNavigationBar:
          // 이건 material 디자인 2버전.
          // BottomNavigationBar(
          //   //type: BottomNavigationBarType.shifting,
          //   //색변하는 신기한 네비게이션 바는 4개 이상부터 백그라운드 컬러가 먹히는데,
          //   //위의 타입으로 쉬프팅을 먹이면, 2~3개의 네비게이션 목록으로도 사용 가능하다.
          //   currentIndex: _selectIndex,
          //   onTap: _onTap,
          //   //selectedItemColor: Theme.of(context).primaryColor,
          //   unselectedItemColor: Colors.grey,
          //   items: const [
          //     BottomNavigationBarItem(
          //       icon: FaIcon(FontAwesomeIcons.house),
          //       label: "Home",
          //       tooltip: "What are you ?",
          //       backgroundColor: Colors.amber,
          //     ),
          //     BottomNavigationBarItem(
          //       icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
          //       label: "Search",
          //       tooltip: "What are you?",
          //       backgroundColor: Colors.blue,
          //     ),
          //     BottomNavigationBarItem(
          //       icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
          //       label: "Search",
          //       tooltip: "What are you?",
          //       backgroundColor: Colors.pink,
          //     ),
          //     BottomNavigationBarItem(
          //       icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
          //       label: "Search",
          //       tooltip: "What are you?",
          //       backgroundColor: Colors.yellow,
          //     ),
          //     BottomNavigationBarItem(
          //       icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
          //       label: "Search",
          //       tooltip: "What are you?",
          //       backgroundColor: Colors.teal,
          //     ),
          //   ],
          // ),
          // 아래는 3버전.
          NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        selectedIndex: _selectIndex,
        onDestinationSelected: _onTap,
        destinations: const [
          NavigationDestination(
            icon: FaIcon(
              FontAwesomeIcons.house,
              color: Colors.teal,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            icon: FaIcon(
              FontAwesomeIcons.magnifyingGlass,
              color: Colors.amber,
            ),
            label: 'Seach',
          ),
        ],
      ),
    );
  }
}
