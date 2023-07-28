import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/inbox/models/chat.dart';
import 'package:tiktok_clone/features/inbox/view_models/chats_view_model.dart';
import 'package:tiktok_clone/features/inbox/views/chat_detail_screen.dart';
import 'package:tiktok_clone/features/inbox/views/select_user_screen.dart';

class ChatsScreen extends ConsumerStatefulWidget {
  static const String routeName = "chats";
  static const String routeURL = "/chats";
  const ChatsScreen({super.key});

  @override
  ConsumerState<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends ConsumerState<ChatsScreen> {
  final GlobalKey<AnimatedListState> _key = GlobalKey<AnimatedListState>();

  final List<int> _items = [];

  final Duration _duration = const Duration(milliseconds: 300);

  void _addItem() {
    // 사용자 선택용를 하나 만들자
    context.pushNamed(SelectUserScreen.routeName);

    if (_key.currentState != null) {
      _key.currentState!.insertItem(_items.length, duration: _duration);
      _items.add(_items.length);
    }
  }

  void _deleteItem(int index, ChatModel chatModel) {
    if (_key.currentContext != null) {
      _key.currentState!.removeItem(
        index,
        (context, animation) => SizeTransition(
          sizeFactor: animation,
          child:
              Container(color: Colors.red, child: _makeTile(index, chatModel)),
        ),
        duration: _duration,
      );
      _items.removeAt(index);
    }
  }

  void _onChatTap(int index) {
    context.pushNamed(
      ChatDetailScreen.routeName,
      params: {"chatId": "$index"},
    );
  }

  Widget _makeTile(index, ChatModel chatModel) {
    return ListTile(
      onLongPress: () => _deleteItem(index, chatModel),
      onTap: () => _onChatTap(index),
      leading: CircleAvatar(
        radius: 30,
        backgroundImage: const NetworkImage(
          "https://avatars.githubusercontent.com/u/594733?s=400&u=51d0a83f972e0f874318c581a91cf0247a927773&v=4",
        ),
        child: Text(chatModel.personA),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            chatModel.personB,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            "2:16 PM",
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: Sizes.size14,
            ),
          ),
        ],
      ),
      subtitle: Text(chatModel.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(chatRoomsModelProvider).when(
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          error: (error, stackTrace) => Center(
            child: Text(
              'Could not load users: $error',
              style: const TextStyle(color: Colors.white),
            ),
          ),
          data: (rooms) {
            return Scaffold(
              appBar: AppBar(
                elevation: 1,
                centerTitle: true,
                title: const Text('Direct message'),
                actions: [
                  IconButton(
                    onPressed: _addItem,
                    icon: const FaIcon(FontAwesomeIcons.plus),
                  ),
                ],
              ),
              body: AnimatedList(
                key: _key,
                padding: const EdgeInsets.symmetric(
                  vertical: Sizes.size10,
                ),
                initialItemCount: rooms.length,
                itemBuilder: (context, index, animation) {
                  final chatRoomData = rooms[index];
                  return FadeTransition(
                    key: UniqueKey(),
                    opacity: animation,
                    child: SizeTransition(
                      sizeFactor: animation,
                      child: _makeTile(index, chatRoomData),
                    ),
                  );
                },
              ),
            );
          },
        );
  }
}
