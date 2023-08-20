import 'package:flutter_test/flutter_test.dart';
import 'package:tiktok_clone/features/videos/models/video_model.dart';

void main() {
  group("VideoModel Test", () {
    test("Constructor", () {
      final video = VideoModel(
        id: "id",
        title: "title",
        description: "description",
        fileUrl: "fileUrl",
        thumbnailUrl: "thumbnailUrl",
        creatorUid: "creatorUid",
        likes: 1,
        comments: 1,
        createdAt: 1,
        creator: "creator",
      );
      expect(video.id, "id");
    });

    test(".fromJson Constructor", () {
      final video = VideoModel.fromJson(
        json: {
          "title": "title",
          "description": "description",
          "fileUrl": "fileUrl",
          "thumbnailUrl": "thumbnailUrl",
          "creatorUid": "creatorUid",
          "likes": 1,
          "comments": 1,
          "createdAt": 1,
          "creator": "creator",
          "id": "id",
        },
        videoId: "videoId",
      );
      expect(video.title, "title");
      expect(video.comments, isInstanceOf<int>());
    });

    test("toJson Method", () {
      final video = VideoModel(
        id: "id",
        title: "title",
        description: "description",
        fileUrl: "fileUrl",
        thumbnailUrl: "thumbnailUrl",
        creatorUid: "creatorUid",
        likes: 1,
        comments: 1,
        createdAt: 1,
        creator: "creator",
      );
      final json = video.toJson();
      expect(json["id"], "id");
      expect(json['likes'], isInstanceOf<int>());
    });
  });
}
