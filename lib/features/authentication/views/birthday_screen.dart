import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/view_models/signup_view_model.dart';
import 'package:tiktok_clone/features/authentication/views/widgets/form_button.dart';

class BirthdayScreen extends ConsumerStatefulWidget {
  const BirthdayScreen({super.key});

  @override
  ConsumerState<BirthdayScreen> createState() => _BirthdayScreenState();
}

class _BirthdayScreenState extends ConsumerState<BirthdayScreen> {
  final TextEditingController _birthdayController = TextEditingController();
  DateTime initialdate = DateTime.now().add(const Duration(days: -365 * 12));
  @override
  void initState() {
    super.initState();
    _setTextFieldDate(initialdate);
  }

  @override
  void dispose() {
    _birthdayController.dispose();
    super.dispose();
  }

  void _onNextTap(BuildContext context) {
    final bDay = _birthdayController.value.text;
    print(bDay);
    final state = ref.read(signUpForm.notifier).state;
    ref.read(signUpForm.notifier).state = {
      ...state,
      "birthday": bDay,
    };

    ref.read(signUpProvider.notifier).signUp(context);

    // // 뒤로 못돌아 가고 interestScreen이 처음이 됨.
    // context.goNamed(InterestsScreen.routeName);

    /* Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const InterestsScreen(),
      ),
      (route) => false,
    ); */
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  void _setTextFieldDate(DateTime date) {
    final textDate = date.toString().split(" ").first;
    _birthdayController.value = TextEditingValue(
      text: textDate,
    );
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
              onTap: () => _onNextTap(context),
              child: FormButton(
                disabled: ref.watch(signUpProvider).isLoading,
                text: 'Next',
              ),
            ),
          ]),
        ),
        bottomNavigationBar: BottomAppBar(
          child: SizedBox(
            height: 300,
            child: CupertinoDatePicker(
              maximumDate: initialdate,
              initialDateTime: initialdate,
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: _setTextFieldDate,
            ),
          ),
        ),
      ),
    );
  }
}
