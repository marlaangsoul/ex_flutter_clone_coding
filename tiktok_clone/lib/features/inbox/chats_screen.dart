import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/inbox/chat_detail_screen.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  final GlobalKey<AnimatedListState> _key =
      GlobalKey<AnimatedListState>(); // 이것을 AnimatedListState에 접근 할수 있도록 해줄 에정.

  final List<int> _item = [];

  final Duration _duration = const Duration(milliseconds: 500);

  void _addItem() {
    if (_key.currentState != null) {
      _key.currentState!.insertItem(_item.length, duration: _duration);
      _item.add(_item.length);
    }
  }

  void _deleteItem(int index) {
    if (_key.currentState != null) {
      _key.currentState!.removeItem(
        index,
        (context, animation) => SizeTransition(
          sizeFactor: animation,
          child: Container(
            color: Colors.red,
            child: _makeTile(
              index,
            ),
          ),
        ),
        duration: _duration,
      );
      _item.removeAt(index);
    }
  }

  void _onChatTap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ChatDetailScreen(),
      ), // 이 부분이 수정된 부분입니다.
    );
  }

  Widget _makeTile(int index) {
    return ListTile(
      onLongPress: () => _deleteItem(index),
      // 그냥 _deleteItem 일때는 인덱스 없이 호출 되고 있으니, () => 로 인덱스를 넣어준다.
      onTap: _onChatTap,
      leading: const CircleAvatar(
        radius: 30,
        foregroundImage: NetworkImage(
            "https://avatars.githubusercontent.com/u/101851921?v=4"),
        child: Text("BH"),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "spectre ($index)",
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          const Text(
            "3:38 PM",
            style: TextStyle(color: Colors.grey, fontSize: Sizes.size12),
          ),
        ],
      ),
      subtitle: const Text("Don`t forget to make video"),
      // trailing: Text(
      //   "3:38 PM",
      //   style: TextStyle(color: Colors.grey, fontSize: Sizes.size16),
      // ), trailing은 ListTile의 가운대로 간다. 그래서 spectre 위치와 맞추고 싶다면  title을 잘라내고, title에 row를 씌운 다음 spaceBetween을 주면 된다.
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1, // 작은 실선.
        title: const Text("Direct messages"),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const FaIcon(FontAwesomeIcons.plus),
          ),
        ],
      ),
      body: AnimatedList(
        //ListView.builder 나 gridView.builder에서는 itemCount를 명시할 수 있었다.
        //itemcount 10 이라고 명시하면, build를 10번 호출 시켰다.
        // AnimatedList에는 initialItemCount가 있는데 이것은 몇개의 아이템을 가지고 시작할지 말해준다.
        key: _key,

        padding: const EdgeInsets.symmetric(horizontal: Sizes.size4),
        itemBuilder: (context, index, Animation<double> animation) {
          return FadeTransition(
            // 애니메이션을 넣기 위한 것.
            key: UniqueKey(), // 플러터가 헷갈리지 않게 추가.(예를 들면 1만 계속 뽑는 다든가...)
            opacity: animation,
            child: ScaleTransition(
              // 아래부터 리스트가 나온다.
              scale: animation,
              child: SizeTransition(
                // 애니메이션이 가운데서 부터 나온다.
                sizeFactor: animation, // 애니메이션이 엄청나게 자연스럽게 된다.
                child: _makeTile(index),
              ),
            ),
          );
        },
      ),
    );
  }
}
