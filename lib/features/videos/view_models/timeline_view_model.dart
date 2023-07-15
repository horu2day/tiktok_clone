import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/videos/repo/videos_repo.dart';

import '../models/video_model.dart';

class TimelineViewModel extends AsyncNotifier<List<VideoModel>> {
  late final VideosRepository _repository;
  List<VideoModel> _list = [];

  // 임시로 만들었던것.
  // void uploadVideo() async {
  //   state = const AsyncValue.loading();
  //   await Future.delayed(const Duration(seconds: 2));

  //   _list = [..._list];
  //   state = AsyncValue.data(_list); //AsyncNotifier 안에 있기 때문에.
  // }
  Future<List<VideoModel>> _fetchVideos({int? lastItemCreatedAt}) async {
    final result = await _repository.fetchVideo(lastItemCreatedAt: null);
    final videos = result.docs.map(
      (doc) => VideoModel.fromJson(
        json: doc.data(),
        videoId: doc.id,
      ),
    );
    return videos.toList();
  }

  @override
  FutureOr<List<VideoModel>> build() async {
    _repository = ref.read(videoRepo);
    _list = await _fetchVideos(lastItemCreatedAt: null);
    return _list;
    //await Future.delayed(const Duration(seconds: 5)); // 나중에 Api에서 온다.
    //에러 발생을 테스트
    //throw Exception("omg can't fetch");
  }

  Future<void> fetchNextPage() async {
    final nextPage =
        await _fetchVideos(lastItemCreatedAt: _list.last.createdAt);
    state = AsyncValue.data([..._list, ...nextPage]);
  }

  Future<void> refresh() async {
    final videos = await _fetchVideos(lastItemCreatedAt: null);
    _list = videos;
    state = AsyncValue.data(videos); //가지고 있던 데이터를 초기화 해서 다 덮어 써버림.
  }
}

final timelineProvider =
    AsyncNotifierProvider<TimelineViewModel, List<VideoModel>>(
  () => TimelineViewModel(),
);
