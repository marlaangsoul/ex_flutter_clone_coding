import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen>
    with
        SingleTickerProviderStateMixin // 매 프레임마다 변화를 콜백 해줌과 동시에 widget treed에 없을때 resource를 낭비하고 있지 않게도 해준다.
{
  final List<String> _notifications = List.generate(20, (index) => "${index}h");
  // 리스르틑 만드는데, List.generate 하면 generate가 위젯을 20번 생성한다.

  final List<Map<String, dynamic>> _tabs = [
    {
      "title": "All activity",
      "icon": FontAwesomeIcons.solidMessage,
    },
    {
      "title": "Likes",
      "icon": FontAwesomeIcons.solidHeart,
    },
    {
      "title": "Comments",
      "icon": FontAwesomeIcons.solidComments,
    },
    {
      "title": "Mentions",
      "icon": FontAwesomeIcons.at,
    },
    {
      "title": "Followers",
      "icon": FontAwesomeIcons.solidUser,
    },
    {
      "title": "From TikTok",
      "icon": FontAwesomeIcons.tiktok,
    }
  ];

  bool _showBarrier = false;

  late final AnimationController _animationController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 200));
  //late를 사용하면 initState를 사용할 것 없이 바로 위와 같이 쓸수 있다.

  // @override
  // void initState() {
  //   super.initState();
  //   _animationController = AnimationController(vsync: this);
  // }

  late final Animation<double> _arrowAnimation =
      Tween(begin: 0.0, end: 0.5).animate(_animationController);

// 사용자에게 animation 효과를 보여주기 위한 방법.
// 첫번째.
// AnimationController의 value를 수정하고, Controller에 eventListener를 추가하는 것.
// 그런 다음 setState를 하면 그게 build 메소드를 실행시키고 사용자에게 애니메이션의 단계들이 보여지는 것.
// 두번째
// Animation Builder를 사용하는 것. Animation Builder가 첫번째 방법의 작업을 대신 해줌.
// 세번째.
// 위와 같은 방법. 위의 두문장과 같이 코딩 후, RotationTransition 사용.

  late final Animation<Offset> _panelAnimation = Tween<Offset>(
    begin: const Offset(0, -1), // 비율이다. 50%
    end: Offset.zero,
  ).animate(_animationController);

  late final Animation<Color?> _barrierAnimation =
      ColorTween(begin: Colors.transparent, end: Colors.black38)
          .animate(_animationController);

  void _onDismissed(String notification) {
    _notifications.remove(notification); // notification 삭제.
    setState(() {});
  }

  void _toggleAnimation() async {
    if (_animationController.isCompleted) {
      await _animationController.reverse();
    } else {
      _animationController.forward();
    }

    setState(() {
      _showBarrier = !_showBarrier;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(_notifications); // 사라지는 것을 확인할 수 있다.
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: _toggleAnimation,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("All activity"),
              Gaps.h12,
              RotationTransition(
                turns: _arrowAnimation,
                child: const FaIcon(
                  FontAwesomeIcons.chevronDown,
                  size: Sizes.size14,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              Gaps.v14,
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.size8,
                ),
                child: Text(
                  'New',
                  style: TextStyle(
                    fontSize: Sizes.size11,
                    color: Colors.grey.shade500,
                  ),
                ),
              ),
              Gaps.v14,
              for (var notification in _notifications)
                Dismissible(
                  // 안에 포함 된 위젯을 좌나 우로 넘겨서 없앨 수 있다.
                  key: Key(notification),
                  onDismissed: (direction) => _onDismissed(notification),
                  background: Container(
                    alignment: Alignment
                        .centerLeft, // Container 안에 있는 아이템들을 정렬 할 수 있게 해준다.
                    color: Colors.green,
                    child: const Padding(
                      padding: EdgeInsets.only(
                        left: Sizes.size12,
                      ),
                      child: FaIcon(
                        FontAwesomeIcons.checkDouble,
                        color: Colors.white,
                        size: Sizes.size32,
                      ),
                    ),
                  ),
                  secondaryBackground: Container(
                    alignment: Alignment.centerRight,
                    color: Colors.red,
                    child: const Padding(
                      padding: EdgeInsets.only(
                        right: Sizes.size12,
                      ),
                      child: FaIcon(
                        FontAwesomeIcons.trashCan,
                        color: Colors.white,
                        size: Sizes.size32,
                      ),
                    ),
                  ),
                  child: ListTile(
                    minVerticalPadding: Sizes.size16, // 최소 간격.
                    leading: Container(
                      width: Sizes.size52,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          // 종에 네모 그리기.
                          color: Colors.grey.shade400,
                          width: Sizes.size1,
                        ),
                        shape: BoxShape.circle, // 종에 네모를 동그라미로 바꾸기.
                      ),
                      child: const Center(
                        child: FaIcon(
                          FontAwesomeIcons.bell,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    title: RichText(
                      text: TextSpan(
                        text: "Account updates:",
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: Sizes.size16),
                        children: [
                          const TextSpan(
                            text: " Upload longer videos",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          TextSpan(
                            text: notification,
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    trailing: const FaIcon(
                      FontAwesomeIcons.chevronRight,
                      size: Sizes.size16,
                    ),
                  ),
                ),
            ],
          ),
          if (_showBarrier)
            AnimatedModalBarrier(
              color: _barrierAnimation,
              dismissible: true,
              onDismiss: _toggleAnimation,
            ),
          SlideTransition(
            position: _panelAnimation,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(Sizes.size5),
                  bottomRight: Radius.circular(Sizes.size5),
                ),
              ),
              child: Column(
                // 컬럼은 수직 축의 최대한의 공간을 사용한다.
                mainAxisSize: MainAxisSize
                    .min, // 따라서 최소한의 공간을 사용하기 위해 MainAxisSize.min을 사용한다.
                children: [
                  for (var tab in _tabs)
                    ListTile(
                      // leading: FaIcon(
                      //   FontAwesomeIcons.user,
                      //   color: Colors.black,
                      //   size: Sizes.size16,
                      // ), 글씨와 너무 떨어져 있어서 다른 것을 사용하자.
                      title: Row(
                        children: [
                          FaIcon(
                            tab["icon"],
                            color: Colors.black,
                            size: Sizes.size16,
                          ),
                          Gaps.h20,
                          Text(
                            tab["title"],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
