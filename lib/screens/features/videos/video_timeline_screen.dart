import 'package:flutter/material.dart';

class VideoTimelineScreen extends StatefulWidget {
  const VideoTimelineScreen({super.key});

  @override
  State<VideoTimelineScreen> createState() => _VideoTimelineScreenState();
}

class _VideoTimelineScreenState extends State<VideoTimelineScreen> {
  int _itemCount = 4;

  List<Color> colors = [
    Colors.blue,
    Colors.red,
    Colors.yellow,
    Colors.teal,
  ];
  void _onPageChanged(int page) {
    if (page == _itemCount - 1) {
      _itemCount = _itemCount + 4;
      colors.addAll([
        Colors.blue,
        Colors.red,
        Colors.yellow,
        Colors.teal,
      ]);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      //pageSnapping: false, //페이지마다 탁탁 걸리지않게
      scrollDirection: Axis.vertical,
      onPageChanged: _onPageChanged,
      itemCount: _itemCount,
      itemBuilder: (context, index) => Container(
        color: colors[index],
        child: Center(
          child: Text(
            "Screen $index",
            style: const TextStyle(fontSize: 68),
          ),
        ),
      ),
      // children: [
      //   Container(
      //     color: Colors.blue,
      //   ),
      //   Container(
      //     color: Colors.teal,
      //   ),
      //   Container(
      //     color: Colors.pink,
      //   ),
      //   Container(
      //     color: Colors.yellow,
      //   ),
      //   Container(
      //     color: Colors.green,
      //   ),
      // ],
    );
  }
}
