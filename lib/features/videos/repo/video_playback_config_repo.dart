// Repository의 역할은 데이터를 Persist(저장)하고 읽는 일만 함.
// 패키지 설치 flutter pub add shared_preferences

import 'package:shared_preferences/shared_preferences.dart';

class VideoPlaybackConfigRepository {
  static const String _autoplay = "autoplay";
  static const String _muted = "mute";

  final SharedPreferences _preferences;

  VideoPlaybackConfigRepository(this._preferences);

  Future<void> setMuted(bool value) async {
    _preferences.setBool(_muted, value);
  }

  Future<void> setAutoplay(bool value) async {
    _preferences.setBool(_autoplay, value);
  }

  bool isMuted() {
    return _preferences.getBool(_muted) ?? false;
  }

  bool isAutoplay() {
    return _preferences.getBool(_autoplay) ?? false;
  }
}
