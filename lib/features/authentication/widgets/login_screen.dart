import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/widgets/auth_button.dart';
import 'package:tiktok_clone/features/authentication/widgets/login_form_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  void _onSignUpTap(BuildContext context) {
    Navigator.of(context).pop();
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (context) => const SignUpScreen(),
    //   ),
    // );
  }

  void _onEmailLoginTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginFormScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.size40),
              child: Column(
                children: [
                  Gaps.v80,
                  const Text(
                    "Login To TikTok",
                    style: TextStyle(
                      fontSize: Sizes.size24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Gaps.v20,
                  const Text(
                    "Manage your account, check notifications, comment on videos, and more",
                    style: TextStyle(
                      fontSize: Sizes.size16,
                      color: Colors.black45,
                    ),
                  ),
                  Gaps.v40,
                  GestureDetector(
                    onTap: () => _onEmailLoginTap(context),
                    child: const AuthButton(
                        icon: FaIcon(FontAwesomeIcons.solidUser),
                        text: "Use Phone or Email"),
                  ),
                  const AuthButton(
                      icon: FaIcon(FontAwesomeIcons.apple),
                      text: "Continue with Apple"),
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            color: Colors.grey.shade100,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: Sizes.size32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don's have an account?"),
                  Gaps.h5,
                  GestureDetector(
                    onTap: () => _onSignUpTap(context),
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).primaryColor),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
