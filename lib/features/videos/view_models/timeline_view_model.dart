import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/video_model.dart';

class TimelineViewModel extends AsyncNotifier<List<VideoModel>> {
  List<VideoModel> _list = [];

  void uploadVideo() async {
    state = const AsyncValue.loading();
    await Future.delayed(const Duration(seconds: 2));
    final newVideo = VideoModel(title: "${DateTime.now()}");
    _list = [..._list, newVideo];
    state = AsyncValue.data(_list); //AsyncNotifier 안에 있기 때문에.
  }

  @override
  FutureOr<List<VideoModel>> build() async {
    await Future.delayed(const Duration(seconds: 5)); // 나중에 Api에서 온다.
    //에러 발생을 테스트
    //throw Exception("omg can't fetch");
    return _list;
  }
}

final timelineProvider =
    AsyncNotifierProvider<TimelineViewModel, List<VideoModel>>(
  () => TimelineViewModel(),
);
