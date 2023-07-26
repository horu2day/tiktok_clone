import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UsersRepo {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<QuerySnapshot<Map<String, dynamic>>> fetchUsers() async {
    return _db.collection("users").orderBy("name", descending: true).get();
  }
}

final usersRepo = Provider((ref) => UsersRepo());
