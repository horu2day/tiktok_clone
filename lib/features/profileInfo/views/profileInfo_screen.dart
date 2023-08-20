import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/view_models/signup_view_model.dart';
import 'package:tiktok_clone/features/authentication/views/widgets/form_button.dart';
import 'package:tiktok_clone/features/users/view_models/users_view_model.dart';

class ProfileInfoScreen extends ConsumerStatefulWidget {
  const ProfileInfoScreen({super.key});

  @override
  ConsumerState<ProfileInfoScreen> createState() => _ProfileInfoScreenState();
}

class _ProfileInfoScreenState extends ConsumerState<ProfileInfoScreen> {
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _linkController = TextEditingController();
  String _bio = '';
  String _link = '';
  void onApplyTap() {
    final users = ref.read(usersProvider.notifier);
    final state = ref.read(signUpForm.notifier).state;
    ref.read(signUpForm.notifier).state = {
      ...state,
      "bio": _bio,
      "line": _link,
    };
    users.profileInfoUpdate(_bio, _link);

    Navigator.of(context).pop();
  }

  @override
  void initState() {
    _bioController.addListener(() {
      setState(() {
        _bio = _bioController.text;
      });
    });
    _linkController.addListener(() {
      setState(() {
        _link = _linkController.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Profile Info'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.size24),
        child: Column(
          children: [
            Gaps.v8,
            const Text(
              'bio',
              style: TextStyle(fontSize: Sizes.size16, color: Colors.black54),
            ),
            TextField(
              controller: _bioController,
              decoration: InputDecoration(
                hintText: 'bio',
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.grey.shade400,
                )),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade400,
                  ),
                ),
              ),
              cursorColor: Theme.of(context).primaryColor,
            ),
            Gaps.v16,
            const Text(
              'link',
              style: TextStyle(fontSize: Sizes.size16, color: Colors.black54),
            ),
            TextField(
              controller: _linkController,
              decoration: InputDecoration(
                hintText: 'link',
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.grey.shade400,
                )),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade400,
                  ),
                ),
              ),
              cursorColor: Theme.of(context).primaryColor,
            ),
            Gaps.v28,
            GestureDetector(
              onTap: onApplyTap,
              child: const FormButton(
                disabled: false,
                text: 'Apply',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
