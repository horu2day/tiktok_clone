import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class ChatDetailScreen extends StatefulWidget {
  const ChatDetailScreen({super.key});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 0),
          horizontalTitleGap: Sizes.size8,
          leading: Stack(
            clipBehavior: Clip.none,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 0),
                child: CircleAvatar(
                  foregroundImage: NetworkImage(
                      "https://avatars.githubusercontent.com/u/594733?s=400&u=51d0a83f972e0f874318c581a91cf0247a927773&v=4"),
                  radius: Sizes.size24,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: Sizes.size20,
                  height: Sizes.size20,
                  decoration: BoxDecoration(
                    color: Colors.lightGreen,
                    border: Border.all(
                      color: Colors.white,
                      width: Sizes.size3,
                    ),
                    borderRadius: BorderRadius.circular(Sizes.size24),
                  ),
                ),
              ),
            ],
          ),
          title: const Text(
            '카오',
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: const Text('Active now'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              FaIcon(
                FontAwesomeIcons.flag,
                color: Colors.black,
                size: Sizes.size20,
              ),
              Gaps.h32,
              FaIcon(
                FontAwesomeIcons.ellipsis,
                color: Colors.black,
                size: Sizes.size20,
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          ListView.separated(
              itemBuilder: (context, index) {
                final isMine = index % 2 == 0;
                return Container(
                  decoration: BoxDecoration(
                    color:
                        isMine ? Colors.blue : Theme.of(context).primaryColor,
                  ),
                  child: const Text(
                    "This is a message",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => Gaps.v10,
              itemCount: 10),
        ],
      ),
    );
  }
}
