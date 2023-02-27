import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';

class VideoButton extends StatelessWidget {
  const VideoButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FaIcon(icon),
        Gaps.v10,
        Text(text),
      ],
    );
  }
}
