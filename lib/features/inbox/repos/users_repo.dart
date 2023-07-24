import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UsersRepo {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Future<void> sendMessage(UserModel user) async {
    await _db
        .collection("users")
        .doc("mso0lHmsVHuOsnQg0BrF")
        .collection("texts")
        .add(
          message.toJson(),
        );
  }
}

final messagesRepo = Provider((ref) => MessagesRepo());
