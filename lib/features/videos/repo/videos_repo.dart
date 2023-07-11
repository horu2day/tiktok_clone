import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/videos/models/video_model.dart';

class VideosRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // upload a video file
  UploadTask uploadVideoFile(File video, String uid) {
    final fileRef = _storage.ref().child(
        "/videos/$uid/${DateTime.now().microsecondsSinceEpoch.toString()}");
    return fileRef.putFile(video);
  }

  // create a video document
  Future<void> saveVideo(VideoModel data) async {
    await _db.collection("videos").add(data.toJson());
  }

  Future<QuerySnapshot<Map<String, dynamic>>> fetchVideo() async {
    //likes 가 10 이상인 비디오 가져오기.
    //_db.collection("videos").where("likes", isGreaterThan: 10).get();
    //생성된 시각순으로 가져오기
    return await _db
        .collection("videos")
        .orderBy("createdAt", descending: true)
        .get();
  }
}

final videoRepo = Provider((ref) => VideosRepository());


/* 
/avatarts/121212
/videos/userid/12121313
 */