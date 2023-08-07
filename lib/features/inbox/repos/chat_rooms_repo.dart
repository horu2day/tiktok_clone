import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/inbox/models/chat.dart';

class ChatRoomsRepo {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Future<QuerySnapshot<Map<String, dynamic>>> fetchRooms() {
    final query = _db.collection("chat_rooms")
        //.orderBy("createdAt", descending: true)
        ;
    return query.get();
  }

  Future<void> createChatRoom(ChatModel room) async {
    await _db.collection("chat_rooms").add(room.toJson());
  }

  Future<Map<String, dynamic>?> findChatRoom(String chatId) async {
    final doc = await _db.collection("chat_rooms").doc(chatId).get();
    return doc.data();
  }
}

final chatRoomsRepo = Provider((ref) => ChatRoomsRepo());
