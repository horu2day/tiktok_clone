import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});
  void _onDmPressed() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        title: const Text('Inbox'),
        actions: [
          IconButton(
            onPressed: _onDmPressed,
            icon: const FaIcon(
              FontAwesomeIcons.paperPlane,
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          const ListTile(
            title: Text(
              'Activity',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: Sizes.size16,
              ),
            ),
            trailing: FaIcon(
              FontAwesomeIcons.chevronRight,
              size: Sizes.size14,
              color: Colors.black,
            ),
          ),
          ListTile(
            leading: Container(
              width: Sizes.size48,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
              child: const Center(
                child: FaIcon(
                  FontAwesomeIcons.users,
                  color: Colors.white,
                ),
              ),
            ),
            title: const Text(
              'New followers',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: Sizes.size16,
              ),
            ),
            subtitle: const Text(
              "Messages from followers will appear here",
              style: TextStyle(
                fontSize: Sizes.size14,
              ),
            ),
            trailing: const FaIcon(
              FontAwesomeIcons.chevronRight,
              size: Sizes.size14,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
