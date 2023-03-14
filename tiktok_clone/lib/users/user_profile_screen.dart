import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: const Text("BH"),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const FaIcon(
                FontAwesomeIcons.gear,
                size: Sizes.size20,
              ),
            ),
          ],
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              const CircleAvatar(
                radius: 50,
                foregroundColor: Colors.teal,
                foregroundImage: NetworkImage(
                    "https://avatars.githubusercontent.com/u/101851921?v=4"),
                child: Text("BH"),
              ),
              Gaps.v20,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "@BH",
                    style: TextStyle(
                        fontWeight: FontWeight.w700, fontSize: Sizes.size16),
                  ),
                  Gaps.h5,
                  FaIcon(
                    FontAwesomeIcons.solidCircleCheck,
                    size: Sizes.size12,
                    color: Colors.blue.shade400,
                  ),
                ],
              ),
              Gaps.v24,
              SizedBox(
                height: Sizes.size40, // VerticalDivider 를 위해 설정.

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        const Text(
                          "97",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Gaps.v3,
                        Text(
                          "Following",
                          style: TextStyle(
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                    VerticalDivider(
                      // 일정한 높이를 가진 Father(SizedBox)가 필요하다.
                      width: Sizes.size32,
                      thickness: Sizes.size1,
                      color: Colors.grey.shade400,
                      indent: Sizes.size14, // 들여쓰기
                      endIndent: Sizes.size14, // 내어 쓰기
                    ),
                    Column(
                      children: [
                        const Text(
                          "10M",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Gaps.v3,
                        Text(
                          "Followers",
                          style: TextStyle(
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                    VerticalDivider(
                      // 일정한 높이를 가진 Father(SizedBox)가 필요하다.
                      width: Sizes.size32,
                      thickness: Sizes.size1,
                      color: Colors.grey.shade400,
                      indent: Sizes.size14, // 들여쓰기
                      endIndent: Sizes.size14, // 내어 쓰기
                    ),
                    Column(
                      children: [
                        const Text(
                          "193.3M",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Gaps.v3,
                        Text(
                          "Likes",
                          style: TextStyle(
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
