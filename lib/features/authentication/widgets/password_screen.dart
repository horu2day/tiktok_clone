import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/widgets/birthday_screen.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_button.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  String _password = '';
  bool _obscureText = true;
  @override
  void initState() {
    super.initState();
    _passwordController.addListener(() {
      setState(() {
        _password = _passwordController.text;
      });
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  bool _isPasswordValid() {
    if (_password.isEmpty) return false;
    if (_password.length < 8) return false;
    if (!_password.contains(RegExp(r"[a-z]"))) return false;
    if (!_password.contains(RegExp(r"[A-Z]"))) return false;
    if (!_password.contains(RegExp(r"[0-9]"))) return false;
    if (!_password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) return false;
    return true;
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  void _onSubmit() {
    if (!_isPasswordValid()) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const BirthdayScreen(),
      ),
    );
  }

  void _onClearTap() {
    _passwordController.clear();
  }

  void _toggleObscureText() {
    _obscureText = !_obscureText;
    setState(() {});
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
              'Password?',
              style: TextStyle(
                  fontSize: Sizes.size20, fontWeight: FontWeight.w600),
            ),
            Gaps.v16,
            TextField(
              controller: _passwordController,
              onEditingComplete: _onSubmit,
              obscureText: _obscureText,
              autocorrect: false,
              decoration: InputDecoration(
                suffix: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: _onClearTap,
                      child: FaIcon(
                        FontAwesomeIcons.solidCircleXmark,
                        color: Colors.grey.shade500,
                        size: Sizes.size20,
                      ),
                    ),
                    Gaps.h16,
                    GestureDetector(
                      onTap: _toggleObscureText,
                      child: FaIcon(
                        _obscureText
                            ? FontAwesomeIcons.eye
                            : FontAwesomeIcons.eyeSlash,
                        color: Colors.grey.shade500,
                        size: Sizes.size20,
                      ),
                    ),
                  ],
                ),
                hintText: 'Make it strong!',
                //errorText: _isPasswordValid(),
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
            Gaps.v10,
            const Text(
              'Your password must have:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Gaps.v10,
            Row(
              children: [
                FaIcon(
                  FontAwesomeIcons.circleCheck,
                  size: Sizes.size20,
                  color:
                      _isPasswordValid() ? Colors.green : Colors.grey.shade400,
                ),
                Gaps.h5,
                const Text('8 to 20 characters')
              ],
            ),
            Gaps.v10,
            Row(
              children: [
                FaIcon(
                  FontAwesomeIcons.circleCheck,
                  size: Sizes.size20,
                  color:
                      _isPasswordValid() ? Colors.green : Colors.grey.shade400,
                ),
                Gaps.h5,
                const Text('Letters, numbers, and special characters')
              ],
            ),
            Gaps.v40,
            GestureDetector(
              onTap: _onSubmit,
              child: FormButton(
                disabled: !_isPasswordValid(),
                text: 'Next',
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
