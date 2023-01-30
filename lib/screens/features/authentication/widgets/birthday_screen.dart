import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/screens/features/authentication/widgets/email_screen.dart';
import 'package:tiktok_clone/screens/features/authentication/widgets/form_button.dart';

class BirthdayScreen extends StatefulWidget {
  const BirthdayScreen({super.key});

  @override
  State<BirthdayScreen> createState() => _BirthdayScreenState();
}

class _BirthdayScreenState extends State<BirthdayScreen> {
  final TextEditingController _birthdayController = TextEditingController();
  DateTime date = DateTime.now();
  @override
  void initState() {
    super.initState();

    final textDate = date.toString().split(" ").first;
    _birthdayController.value = TextEditingValue(
      text: textDate,
    );
  }

  @override
  void dispose() {
    _birthdayController.dispose();
    super.dispose();
  }

  void onNextTap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const EmailScreen(),
      ),
    );
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Sign Up'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size36),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Gaps.v40,
            const Text(
              "When's your birthday?",
              style: TextStyle(
                  fontSize: Sizes.size20, fontWeight: FontWeight.w600),
            ),
            Gaps.v8,
            const Text(
              "Your birthday won's be shown publicly",
              style: TextStyle(fontSize: Sizes.size16, color: Colors.black54),
            ),
            TextField(
              enabled: false,
              controller: _birthdayController,
              decoration: InputDecoration(
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
              onTap: onNextTap,
              child: const FormButton(disabled: false),
            ),
          ]),
        ),
        bottomNavigationBar: BottomAppBar(
            child: CupertinoDatePicker(
          onDateTimeChanged: (DateTime value) {},
        )),
      ),
    );
  }
}
