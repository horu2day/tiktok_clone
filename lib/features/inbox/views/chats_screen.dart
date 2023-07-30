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

    // if (_key.currentState != null) {
    //   _key.currentState!.insertItem(_items.length, duration: _duration);
    //   _items.add(_items.length);
    // }
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

  void _onChatTap(String chatId) {
    context.pushNamed(
      ChatDetailScreen.routeName,
      params: {"chatId": chatId},
    );
  }

  Widget _makeTile(index, ChatModel chatModel) {
    return ListTile(
      onLongPress: () => _deleteItem(index, chatModel),
      onTap: () => _onChatTap(chatModel.id),
      leading: CircleAvatar(
        radius: 30,
        foregroundImage: NetworkImage(
            "https://firebasestorage.googleapis.com/v0/b/tictok-kms6600.appspot.com/o/avatar%2F${chatModel.personA}?alt=media&token=24efe12b-aac6-4ff1-ae73-cdbc4a5fd3c5"),
        //: Text(chatModel.personAName),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            chatModel.personAName,
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
      subtitle: Text(chatModel.personABio),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(chatsProvider).when(
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
