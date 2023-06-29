import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class Avatar extends ConsumerWidget {
  final String name;
  const Avatar({
    super.key,
    required this.name,
  });

  Future<void> _onAvatarTap() async {
    final xfile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 40,
      maxHeight: 150,
      maxWidth: 150,
    );
    if (xfile != null) {
      final file = File(xfile.path);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: _onAvatarTap,
      child: CircleAvatar(
        radius: 30,
        foregroundColor: Colors.teal,
        foregroundImage: const NetworkImage(
            "https://avatars.githubusercontent.com/u/594733?s=400&u=51d0a83f972e0f874318c581a91cf0247a927773&v=4"),
        child: Text(name),
      ),
    );
  }
}
