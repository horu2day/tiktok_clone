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

  Future<QuerySnapshot<Map<String, dynamic>>> fetchVideo(
      {int? lastItemCreatedAt}) async {
    //likes 가 10 이상인 비디오 가져오기.
    //_db.collection("videos").where("likes", isGreaterThan: 10).get();
    //생성된 시각순으로 가져오기
    final query = _db
        .collection("videos")
        .orderBy("createdAt", descending: true)
        .limit(2);

    if (lastItemCreatedAt == null) {
      return query.get();
    } else {
      return query.startAfter([lastItemCreatedAt]).get();
    }

    // .startAfter([3]) // createdAt 으로 Ordering 한 다음 3번 다음부터 시작하고 싶다는 의미(4,5)
    // 배열을 쓴것은 여러필드들 다중 Ordering으로 우선순위에서 시작순서를 정함.
  }
}

final videoRepo = Provider((ref) => VideosRepository());


/* 
/avatarts/121212
/videos/userid/12121313
 */