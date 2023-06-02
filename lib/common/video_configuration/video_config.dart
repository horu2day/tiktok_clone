import 'package:flutter/material.dart';

class VideoConfig extends InheritedWidget {
  const VideoConfig({super.key, required super.child});

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
