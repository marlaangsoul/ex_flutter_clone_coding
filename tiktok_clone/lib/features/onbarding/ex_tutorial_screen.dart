
// // 온보딩 페이지 좌우 스크롤 연습.

// class TutorialScreen extends StatefulWidget {
//   const TutorialScreen({super.key});

//   @override
//   State<TutorialScreen> createState() => _TurorialScreenState();
// }

// class _TurorialScreenState extends State<TutorialScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       // TabBarView 를 사용할 때 컨트롤러를 만들거나,
//       // 혹은 위의 기본 탭 컨트롤러를 더 위에 감싸서 사용할수있다.
//       length: 3,
//       child: Scaffold(
//         body: SafeArea(
//           // appbar 가 없으니, 맨 위 배터리 등 알림창 공간을 피하기 위해 사용.
//           child: TabBarView(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: Sizes.size24,
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: const [
//                     Gaps.v52,
//                     Text(
//                       "Follow the rules of the app!",
//                       style: TextStyle(
//                         fontSize: Sizes.size40,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Gaps.v16,
//                     Text(
//                       "Videos are personalized for you based on what you watch, like, and share.",
//                       style: TextStyle(
//                         fontSize: Sizes.size20,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: Sizes.size24,
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: const [
//                     Gaps.v52,
//                     Text(
//                       "Enjoy the ride",
//                       style: TextStyle(
//                         fontSize: Sizes.size40,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Gaps.v16,
//                     Text(
//                       "Videos are personalized for you based on what you watch, like, and share.",
//                       style: TextStyle(
//                         fontSize: Sizes.size20,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: Sizes.size24,
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: const [
//                     Gaps.v52,
//                     Text(
//                       "Watch cool videos!",
//                       style: TextStyle(
//                         fontSize: Sizes.size40,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Gaps.v16,
//                     Text(
//                       "Videos are personalized for you based on what you watch, like, and share.",
//                       style: TextStyle(
//                         fontSize: Sizes.size20,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         bottomNavigationBar: BottomAppBar(
//           child: Container(
//             padding: const EdgeInsets.symmetric(
//               vertical: Sizes.size48,
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: const [
//                 TabPageSelector(
//                   color: Colors.white,
//                   selectedColor: Colors.black38,
//                 ),
//               ], // DefaultTabController안에 적는게 중요.
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
