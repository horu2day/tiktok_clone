import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectUsersRepo {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<QuerySnapshot<Map<String, dynamic>>> fetchUsers() async {
    return _db.collection("users").orderBy("name", descending: true).get();
  }

  // Future<void> saveVideo(ChatModel data) async {
  //   await _db.collection("videos").add(data.toJson());
  // }
}

final selectUsersRepo = Provider((ref) => SelectUsersRepo());
