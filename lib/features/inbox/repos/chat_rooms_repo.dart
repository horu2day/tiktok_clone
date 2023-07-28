import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatRoomsRepo {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Future<QuerySnapshot<Map<String, dynamic>>> fetchRooms() {
    final query = _db.collection("chat_rooms")
        //.orderBy("createdAt", descending: true)
        ;
    return query.get();
  }
}

final chatRoomsRepo = Provider((ref) => ChatRoomsRepo());
