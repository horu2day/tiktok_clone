import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class UsernameScreen extends StatelessWidget {
  const UsernameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.size36),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Gaps.v40,
              Text(
                'Create username',
                style: TextStyle(
                    fontSize: Sizes.size20, fontWeight: FontWeight.w600),
              ),
              Gaps.v10,
              Text(
                'You can always change this later',
                style: TextStyle(fontSize: Sizes.size16, color: Colors.black54),
              ),
            ]),
      ),
    );
  }
}
