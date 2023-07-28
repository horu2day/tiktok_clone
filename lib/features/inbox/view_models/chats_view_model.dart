import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/inbox/models/chat.dart';
import 'package:tiktok_clone/features/inbox/repos/chat_rooms_repo.dart';

class ChatsViewModel extends AsyncNotifier<List<ChatModel>> {
  late final ChatRoomsRepo _repo;
  List<ChatModel> _list = [];
  @override
  FutureOr<List<ChatModel>> build() async {
    _repo = ref.read(chatRoomsRepo);
    _list = await _fetchRooms();
    return _list;
  }

  Future<List<ChatModel>> _fetchRooms() async {
    final result = await _repo.fetchRooms();
    final rooms = result.docs.map(
      (doc) => ChatModel.fromJson(
        json: doc.data(),
        chatId: doc.id,
      ),
    );

    return rooms.toList();
  }
}

final chatRoomsModelProvider =
    AsyncNotifierProvider<ChatsViewModel, List<ChatModel>>(
  () => ChatsViewModel(),
);
