import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/users/models/user_profile_model.dart';

class UserRepository {
  //DB 생성
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  //create profile
  Future<void> createProfile(UserProfileModel profile) async {
    await _db.collection("users").doc(profile.uid).set(profile.toJson());
  }

  //get profile
  Future<Map<String, dynamic>?> findProfile(String uid) async {
    final doc = await _db.collection("users").doc(uid).get();
    return doc.data();
  }

  //update avatar
  Future<void> uploadAvatar(File file, String fileName) async {
    //폴더에 파일이름을 넣으주면 됨. 아래 경로를 예약하고, 파일을 올리는 것임.
    final fileRef = _storage.ref().child("avatar/$fileName");
    await fileRef.putFile(file);
  }
  //update bio
  //update link
}

final userRepo = Provider(
  (ref) => UserRepository(),
);
