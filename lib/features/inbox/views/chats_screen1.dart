//=========================================================
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/inbox/view_models/chats_view_model.dart';

class ChatsScreen1 extends ConsumerStatefulWidget {
  static const String routeName = "chats";
  static const String routeURL = "/chats";
  const ChatsScreen1({super.key});

  @override
  ConsumerState<ChatsScreen1> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends ConsumerState<ChatsScreen1> {
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
                title: const Text('Direct messages'),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const FaIcon(FontAwesomeIcons.plus),
                  ),
                ],
              ),
              body: AnimatedList(
                padding: const EdgeInsets.symmetric(
                  vertical: Sizes.size10,
                ),
                initialItemCount: rooms.length,
                itemBuilder: (context, index, animation) {
                  final chatRoomData = rooms[index];
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      foregroundImage: const NetworkImage(
                        "https://avatars.githubusercontent.com/u/3612017",
                      ),
                      child: Text(chatRoomData.personA),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Lynn ($index)",
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "2:16 PM",
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: Sizes.size12,
                          ),
                        ),
                      ],
                    ),
                    subtitle: Text(chatRoomData.personB),
                  );
                },
              ),
            );
          },
        );
  }
}
