// import 'package:flutter/material.dart';
// import 'package:tiktok_clone/constants/sizes.dart';

// class UserProfileScreen extends StatefulWidget {
//   const UserProfileScreen({super.key});

//   @override
//   State<UserProfileScreen> createState() => _UserProfileScreenState();
// }

// class _UserProfileScreenState extends State<UserProfileScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return CustomScrollView(
//       slivers: [
//         // 유저가 스크롤 할 수 있는 것들.
//         SliverAppBar(
//           // appbar와 같으나 스크롤 할수 있다.
//           // floating: true, //스크롤을 한없이 내리다가 살찍 위로 올리면 appbar의 전체 이미지가 나타난다. 그리고 올라가는 동안에는 계속 남아 있는다.
//           // snap:true, // floating과 함께 사용 된다. 살짝만 내려도 appBar가 쑥 내려온다. 즉 기다리지 않고 appbar를 위나 아래로 나타나게 한다.
//           pinned: true, //내가 맨 위로 올라가서 첫번째를 건드리면 나타나게 된다.
//           stretch:
//               true, // appbar를 아래로 늘어 뜨릴수 있는데, 아래와 같은 모드를 통해 여러 효과를 줄수 있다. ex) 블러 효과를 준다.
//           backgroundColor: Colors.teal,
//           collapsedHeight: 80, // appbar가 100까지 줄어들다가 그 이후로 title이 사라진다.
//           expandedHeight: 200, // appbar의 넓이가 300만큼 커진다.
//           flexibleSpace: FlexibleSpaceBar(
//             stretchModes: const [
//               StretchMode.blurBackground,
//               //StretchMode.fadeTitle,
//               StretchMode.zoomBackground
//             ],
//             background: Image.asset(
//               "assets/images/spectre.png",
//               fit: BoxFit.cover,
//             ),
//           ),
//           title: const Text("hello"),
//         ),
//         SliverFixedExtentList(
//           delegate: SliverChildBuilderDelegate(
//             childCount: 50,
//             (context, index) => Container(
//               color: Colors.amber[100 * (index % 9)],
//               child: Align(
//                 alignment: Alignment.center,
//                 child: Text("item $index"),
//               ),
//             ),
//           ),
//           itemExtent: 100,
//         ),
//         SliverPersistentHeader(
//           delegate: CustomDelegate(),
//           pinned: true,
//           floating: true, // 바로 나타나는 옵션
//         ),
//         SliverGrid(
//             delegate: SliverChildBuilderDelegate(
//               childCount: 50,
//               (context, index) => Container(
//                 color: Colors.blue[100 * (index % 9)],
//                 child: Align(
//                   alignment: Alignment.center,
//                   child: Text("item $index"),
//                 ),
//               ),
//             ),
//             gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
//               maxCrossAxisExtent: 100,
//               mainAxisSpacing: Sizes.size20,
//               crossAxisSpacing: Sizes.size20,
//               childAspectRatio: 1,
//             ))
//       ],
//     );
//   }
// }

// class CustomDelegate extends SliverPersistentHeaderDelegate {
//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return Container(
//       color: Colors.indigo,
//       child: const FractionallySizedBox(
//         // FaractionallySizedBox 는 부모로 부터 최대한 많은 공간을 차지하는 사이즈 박스
//         heightFactor: 1, //모든 부분을 차지 할수 있게 1.
//         child: Center(child: Text("Title")),
//       ),
//     );
//   }

//   @override
//   double get maxExtent => 150; //최대 높이

//   @override
//   double get minExtent => 80; // 최저 높이
//   // 둘 다 getter이기 때문에 double을 return 해줘야 함,.

//   @override
//   bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
//     return false;
//   }
// }
