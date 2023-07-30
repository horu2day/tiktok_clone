import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/inbox/models/chat.dart';
import 'package:tiktok_clone/features/inbox/repos/chat_rooms_repo.dart';
import 'package:tiktok_clone/features/users/models/user_profile_model.dart';
import 'package:tiktok_clone/features/users/repos/user_repo.dart';

class ChatsViewModel extends AsyncNotifier<List<ChatModel>> {
  late final ChatRoomsRepo _repo;
  late final UserRepository _userRepo;

  List<ChatModel> _list = [];
  @override
  FutureOr<List<ChatModel>> build() async {
    _repo = ref.read(chatRoomsRepo);
    _userRepo = ref.read(userRepo);
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

  Future<List<ChatModel>> createChatRoom(UserProfileModel your) async {
    final user = ref.read(authRepo);

    state = const AsyncValue.loading();
    try {
      final chatRoom = ChatModel(
        id: "",
        personA: your.uid,
        personAName: your.name,
        personABio: your.bio,
        personB: user.user!.uid,
        createdAt: DateTime.now().millisecondsSinceEpoch,
      );
      await _repo.createChatRoom(chatRoom);
      _list = await _fetchRooms(); // Fetch the updated list of chat models
      state =
          AsyncData(_list); // Update the state with the new list of chat models
      return _list; // Return the updated list of chat models
    } catch (error) {
      state = AsyncError(error, StackTrace.current);
      rethrow; // Re-throw the error to notify callers about the failure
    }
  }

  Future<UserProfileModel> findUser(String userId) async {
    final profile = await _userRepo.findProfile(userId);
    return UserProfileModel.fromJson(profile!);
  }
}

final chatsProvider = AsyncNotifierProvider<ChatsViewModel, List<ChatModel>>(
  () => ChatsViewModel(),
);
