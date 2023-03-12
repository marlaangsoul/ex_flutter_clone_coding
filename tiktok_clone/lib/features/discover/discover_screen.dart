import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

final tabs = ["BH", "Car", "RR ", "Spectre", "DAWN", "Shopping", "Brands"];

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final TextEditingController _textEditingController =
      TextEditingController(text: "Initial Text");

  void _onSearchChanged(String value) {
    //print("Changed $value");
  }

  void _onSearchSubmitted(String value) {
    // print("Submitted $value");
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        resizeToAvoidBottomInset:
            false, // scaffold는 자동으로 화면을 리사이즈 해주는데, 키보드가 올라오면서 아래 컨텐츠가 없어지는 상황을 막기위해 리사이즈를 false해준다.
        appBar: AppBar(
          elevation: Sizes.size1, // 전체 밑줄
          title: CupertinoSearchTextField(
            // 여기서는 텍스트 커서의 색을 바꿀수 없으나 메인.dart에서 테마 컬러로 바꿀수 있다.
            controller: _textEditingController,
            onChanged: _onSearchChanged,
            onSubmitted: _onSearchSubmitted,
          ), // 검색 텍스트 필드를 만들어 준다.
          bottom: TabBar(
            isScrollable: true, // 좌우 스크롤
            splashFactory: NoSplash.splashFactory, //버튼을 눌렀을때 스플래쉬 효과
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size16),
            // 탭을 사용할 때 쓴다.
            // 그리고 DefaultTabController가 필요하다.
            labelColor: Colors.black, // 항목 색.
            unselectedLabelColor: Colors.grey.shade500, // 미 선택시 색
            indicatorColor: Colors.black, // 바닥 밑줄 색
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: Sizes.size16,
            ),
            tabs: [
              for (var tab in tabs)
                Tab(
                  text: tab,
                )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            GridView.builder(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior
                  .onDrag, // 드래그가 될때 키보드가 자동으로 사라지게 만들어준다.
              padding: const EdgeInsets.all(Sizes.size6),
              //마치 listview 같은 것인데, pageview와 같이 vuilder를 사용하는게 더 좋은 퍼포먼스를 보여준다. children이 있는 gridview는 성능적으로 좋지 않다.
              itemCount: 20, // 개수
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount
                  // 몇개의 칼럼을 가질지 정해준다.
                  (
                crossAxisCount: 2, // 한줄 개수
                childAspectRatio: 9 / 20, // 한칸 비율
                crossAxisSpacing: Sizes.size10, //좌우 간견.
                mainAxisSpacing: Sizes.size10,
              ),
              itemBuilder: (context, index) =>
                  //Image.asset("assets/images/spectre.png"), // 폴더 예시
                  //Image.network("https://car-logos.net/wp-content/uploads/2018/09/rolls-royce-logo.jpg",

                  // placeholder로 보여줄 이미지가 우리의 asset폴더에 있을 거라는 것.
                  // image 가 로딩 될 때 동안, placeholder의 이미지가 나타난다.
                  Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Sizes.size10),
                    ), // 컨테이너를 레이도 처리 .
                    clipBehavior: Clip
                        .hardEdge, // 그런데 컨테이너가 오버 플로우 되어 있기 떄문에 하드 엣지로 잘라 줘야 함.

                    child: AspectRatio(
                      // 비율을 설정할 수 있다.
                      aspectRatio: 9 / 16, // 비율을 9/ 16  으로 설정.
                      child: FadeInImage.assetNetwork(
                        // fit은 이미지가 어떤 방식으로 부모요소에 적용 될지 정해준다.
                        fit: BoxFit.cover,
                        placeholder: "assets/images/spectre.png",
                        image:
                            "https://www.designyourway.net/blog/wp-content/uploads/2019/10/s1-51.jpg",
                      ),
                    ),
                  ),
                  Gaps.v10,
                  const Text(
                    "Tehis is my car. My car is rolls-royce spectre and dawn and phantom",
                    style: TextStyle(
                      fontSize: Sizes.size16 + Sizes.size2,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis, // 말 줄임 표
                  ),
                  Gaps.v5,
                  DefaultTextStyle(
                    // 폰트 스타일을 자식 위젯들에 모두 동일하게 적용 시킬 수 있는 위젯.
                    style: TextStyle(
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w600),
                    child: Row(
                      children: const [
                        CircleAvatar(
                          radius: Sizes.size14, // 사이즈.
                          backgroundImage: NetworkImage(
                            "https://avatars.githubusercontent.com/u/101851921?v=4",
                          ),
                        ),
                        Gaps.h4,
                        Expanded(
                          // 해당 공간을 모두 사용하는 expanded를 사용.
                          child: Text(
                            "My avatar is going to be long",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Gaps.h4,
                        FaIcon(
                          FontAwesomeIcons.heart,
                          size: Sizes.size20,
                          color: Colors.grey,
                        ),
                        Gaps.h2,
                        Text(
                          "338M",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            for (var tab in tabs.skip(1)) // .skip(1) : 첫번쨰 꺼는 스킵해라.
              Center(
                child: Text(
                  tab,
                  style: const TextStyle(fontSize: Sizes.size28),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
