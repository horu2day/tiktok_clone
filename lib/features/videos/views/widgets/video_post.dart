import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/videos/models/video_model.dart';
import 'package:tiktok_clone/features/videos/view_models/playback_config_vm.dart';
import 'package:tiktok_clone/features/videos/view_models/video_post_view_model.dart';
import 'package:tiktok_clone/features/videos/views/widgets/video_button.dart';
import 'package:tiktok_clone/features/videos/views/widgets/video_comments.dart';
import 'package:tiktok_clone/generated/l10n.dart';

import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPost extends ConsumerStatefulWidget {
  final Function onVideoFinished;
  final VideoModel videoData;

  final int index;

  const VideoPost({
    super.key,
    required this.videoData,
    required this.onVideoFinished,
    required this.index,
  });

  @override
  VideoPostState createState() => VideoPostState();
}

class VideoPostState extends ConsumerState<VideoPost>
    with SingleTickerProviderStateMixin {
  final VideoPlayerController _videoPlayerController =
      VideoPlayerController.asset("assets/videos/video.mp4");
  final Duration _animationDuration = const Duration(milliseconds: 200);
  late AnimationController _animationController;
  bool _isPaused = false;

  bool _currentMute = false;
  //bool _autoMute = videoConfig.value;

  void _onVideoChange() {
    if (_videoPlayerController.value.isInitialized) {
      if (_videoPlayerController.value.duration ==
          _videoPlayerController.value.position) {
        widget.onVideoFinished();
      }
    }
  }

  void _onLikeTap() {
    ref.read(videoPostProvider(widget.videoData.id).notifier).likeVideo();
  }

  void _initVideoPlayer() async {
    await _videoPlayerController.initialize();
    //_videoPlayerController.play();
    setState(() {});
    if (kIsWeb) {
      // Web인지 아닌지 여부
      await _videoPlayerController.setVolume(0);
    }
    await _videoPlayerController.setLooping(true);
    _videoPlayerController.addListener(_onVideoChange);
  }

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();

    _animationController = AnimationController(
      vsync: this,
      lowerBound: 1.0,
      upperBound: 1.5,
      value: 1.5,
      duration: _animationDuration,
    );
    // 2번 방법 : AnimatedBuilder를 사용하는 방법 -> 위젯에서 직접 사용
    // 1번 방법
    // _animationController.addListener(() {
    //   setState(() {});
    // });

    //notifyListner 호출시 실행.
    // videoConfig.addListener(() {
    //   setState(() {
    //     _autoMute = videoConfig.value;
    //   });
    // });
    //_currentMute = _isMuted = context.read<PlaybackConfigViewModel>().muted;
    // context
    //     .read<PlaybackConfigViewModel>()
    //     .addListener(_onPlaybackConfigChanged);
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  void _onPlaybackConfigChanged() {
    if (!mounted) return;
    //final muted = context.read<PlaybackConfigViewModel>().muted;
    if (ref.read(playbackConfigProvider).muted) {
      _videoPlayerController.setVolume(0);
    } else {
      _videoPlayerController.setVolume(1);
    }
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (!mounted) return;
    //Play가 되는 조건 ,영상이 전부 화면에 들어 있으면서 재생이 안되고 있을때 Play해라
    if (info.visibleFraction == 1 &&
        !_isPaused &&
        !_videoPlayerController.value.isPlaying) {
      //final autoplay = context.read<PlaybackConfigViewModel>().autoplay;
      if (ref.read(playbackConfigProvider).autoplay) {
        _videoPlayerController.play();
      }
    }
    //멈추는 조건 , 비디오가 플레이중인데, 화면에 보이지 않는 다면 멈춰.
    if (_videoPlayerController.value.isPlaying && info.visibleFraction == 0) {
      _onTogglePause();
    }
  }

  void _onTogglePause() {
    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
      _animationController.reverse();
    } else {
      _videoPlayerController.play();
      _animationController.forward();
    }
    setState(() {
      _isPaused = !_isPaused;
    });
  }

  void _onVolumeOnOff() {
    if (kIsWeb) {
      // Web인지 아닌지 여부
      _videoPlayerController.setVolume(20);
      setState(() {
        _currentMute = !_currentMute;
      });
    }
  }

  Future<void> _onCommentTap(BuildContext context) async {
    if (_videoPlayerController.value.isPlaying) {
      _onTogglePause();
    }
    await showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Sizes.size16),
      ),
      context: context,
      isScrollControlled: true,
      builder: (context) => const VideoComments(),
    );
    _onTogglePause();
  }

  @override
  Widget build(BuildContext context) {
    // final videoConfig =
    //     context.dependOnInheritedWidgetOfExactType<VideoConfig>();
    // print(videoConfig?.autoMute);

    return VisibilityDetector(
      key: Key("${widget.index}"),
      onVisibilityChanged: _onVisibilityChanged,
      child: Stack(
        children: [
          Positioned.fill(
            child: _videoPlayerController.value.isInitialized
                ? VideoPlayer(_videoPlayerController)
                : Image.network(
                    widget.videoData.thumbnailUrl,
                    fit: BoxFit.cover,
                  ),
          ),
          Positioned.fill(
            child: GestureDetector(
              onTap: _onTogglePause,
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              child: Center(
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _animationController.value,
                      child: child,
                    );
                  },
                  child: AnimatedOpacity(
                    opacity: _isPaused ? 1 : 0,
                    duration: _animationDuration,
                    child: const FaIcon(
                      FontAwesomeIcons.play,
                      color: Colors.white,
                      size: Sizes.size52,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 20,
            top: 40,
            child: IconButton(
              icon: FaIcon(
                ref.watch(playbackConfigProvider).muted
                    // 2. context
                    //         .watch<VideoConfig>()
                    //         .isMuted
                    // 1. VideoConfigData.of(context).autoMute
                    ? FontAwesomeIcons.volumeOff
                    : FontAwesomeIcons.volumeHigh,
                color: Colors.white,
              ),
              onPressed: _onPlaybackConfigChanged,

              //videoConfig.value = !videoConfig.value,
              //VideoConfigData.of(context).toggleMuted();
            ),
          ),
          Positioned(
            bottom: 20,
            left: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "@${widget.videoData.creator}",
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: Sizes.size20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gaps.v24,
                Text(
                  widget.videoData.description,
                  style: const TextStyle(
                    fontSize: Sizes.size16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            right: 10,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  foregroundImage: NetworkImage(
                      "https://firebasestorage.googleapis.com/v0/b/tictok-kms6600.appspot.com/o/avatar%2F${widget.videoData.creatorUid}?alt=media&token=24efe12b-aac6-4ff1-ae73-cdbc4a5fd3c5"),
                  child: Text(widget.videoData.creator),
                ),
                Gaps.v24,
                GestureDetector(
                  onTap: _onLikeTap,
                  child: VideoButton(
                    icon: FontAwesomeIcons.solidHeart,
                    text: S.of(context).likeCount(widget.videoData.likes),
                  ),
                ),
                Gaps.v24,
                GestureDetector(
                  onTap: () => _onCommentTap(context),
                  child: VideoButton(
                    icon: FontAwesomeIcons.solidComment,
                    text: S.of(context).commentCount(
                          widget.videoData.comments,
                        ),
                  ),
                ),
                Gaps.v24,
                const VideoButton(
                  icon: FontAwesomeIcons.share,
                  text: "Share",
                ),
                Gaps.v24,
                GestureDetector(
                  onTap: () => _onVolumeOnOff,
                  child: VideoButton(
                    icon: _currentMute
                        ? FontAwesomeIcons.volumeXmark
                        : FontAwesomeIcons.volumeHigh,
                    text: _currentMute ? "mute" : "vol",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
