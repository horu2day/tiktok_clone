import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/view_models/social_auth_view_model.dart';

import 'package:tiktok_clone/features/authentication/widgets/auth_button.dart';
import 'package:tiktok_clone/features/authentication/widgets/login_screen.dart';
import 'package:tiktok_clone/features/authentication/widgets/username_screen.dart';
import 'package:tiktok_clone/generated/l10n.dart';
import 'package:tiktok_clone/utils.dart';

class SignUpScreen extends ConsumerWidget {
  static const String routeURL = "/";
  static const String routeName = "signUp";
  const SignUpScreen({super.key});
  void _onLoginTap(BuildContext context) async {
    context.pushNamed(LoginScreen.routeName);
    // final result = Navigator.of(context).pushNamed(LoginScreen.routeName);
    // print(result);
  }

  void _onEmailTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const UsernameScreen(),
      ),
    );
    //context.pushNamed(UsernameScreen.routeName);
    //Navigator.of(context).pushNamed(UsernameScreen.routeName);
    //아래는 #17.2 PageRouteBuilder 코드임
    /*Navigator.of(context).push(PageRouteBuilder(
        transitionDuration: const Duration(
          seconds: 1,
        ),
        reverseTransitionDuration: const Duration(seconds: 1),
        pageBuilder: (context, amimation, secondaryAnimation) =>
            const UsernameScreen(),
        // 아래 리턴되는 child 는 pageBuilder가 만들어내는 무엇을 말함.
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final offsetAnimation = Tween(
            begin: const Offset(0, 1), // -1 이면 위에서 떨어지는 1 이면 아래에서 올라온다.
            end: Offset.zero,
          ).animate(animation);
          final opacityAmimation = Tween(
            begin: 0.5,
            end: 1.0,
          ).animate(animation);
          return SlideTransition(
            position: offsetAnimation,
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        }
        //     ScaleTransition(
        //   scale: animation,
        //   child: FadeTransition(
        //     opacity: animation,
        //     child: child,
        //   ),
        // ),

        )); */
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size40),
          child: Column(
            children: [
              Gaps.v80,
              Text(
                S.of(context).signUpTitle("TikTok", DateTime.now()),
                style: const TextStyle(
                  fontSize: Sizes.size24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Gaps.v20,
              Opacity(
                opacity: 0.7,
                child: Text(
                  S.of(context).signUpSubtitle(33425),
                  style: const TextStyle(
                    fontSize: Sizes.size16,
                  ),
                ),
              ),
              Gaps.v40,
              GestureDetector(
                onTap: () => _onEmailTap(context),
                child: AuthButton(
                    icon: const FaIcon(FontAwesomeIcons.solidUser),
                    text: S.of(context).emailPasswordButton),
              ),
              Gaps.v10,
              GestureDetector(
                onTap: () =>
                    ref.read(socialAuthProvider.notifier).githubSignIn(context),
                child: const AuthButton(
                    icon: FaIcon(FontAwesomeIcons.github),
                    text: "Continue with Github"),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: isDarkMode(context) ? null : Colors.grey.shade50,
        child: Padding(
          padding: const EdgeInsets.only(
            top: Sizes.size32,
            bottom: Sizes.size64,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(S.of(context).alreadyHaveAnAcount),
              Gaps.h5,
              GestureDetector(
                onTap: () => _onLoginTap(context),
                child: Text(
                  S.of(context).logIn("female"),
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
  }
}
