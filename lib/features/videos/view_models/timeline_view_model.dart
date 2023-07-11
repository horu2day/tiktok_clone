import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/videos/repo/videos_repo.dart';

import '../models/video_model.dart';

class TimelineViewModel extends AsyncNotifier<List<VideoModel>> {
  late final VideosRepository _repository;
  final List<VideoModel> _list = [];

  // 임시로 만들었던것.
  // void uploadVideo() async {
  //   state = const AsyncValue.loading();
  //   await Future.delayed(const Duration(seconds: 2));

  //   _list = [..._list];
  //   state = AsyncValue.data(_list); //AsyncNotifier 안에 있기 때문에.
  // }

  @override
  FutureOr<List<VideoModel>> build() async {
    _repository = ref.read(videoRepo);
    final result = await _repository.fetchVideo();
    result.docs.map((e) => null);
    //await Future.delayed(const Duration(seconds: 5)); // 나중에 Api에서 온다.
    //에러 발생을 테스트
    //throw Exception("omg can't fetch");
    return _list;
  }
}

final timelineProvider =
    AsyncNotifierProvider<TimelineViewModel, List<VideoModel>>(
  () => TimelineViewModel(),
);
