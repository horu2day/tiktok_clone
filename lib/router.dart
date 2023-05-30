import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/features/authentication/widgets/login_screen.dart';
import 'package:tiktok_clone/features/authentication/widgets/sign_up_screen.dart';
import 'package:tiktok_clone/features/main_navigation/main_navigation_screen.dart';
import 'package:tiktok_clone/features/onboarding/interests_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      name: SignUpScreen.routeName,
      path: SignUpScreen.routeURL,
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      name: LoginScreen.routeName,
      path: LoginScreen.routeURL,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      name: InterestsScreen.routeName,
      path: InterestsScreen.routeURL,
      builder: (context, state) => const InterestsScreen(),
    ),
    GoRoute(
      name: MainNavigationScreen.routeName,
      path: "/:tab(home|discover|inbox|profile)",
      builder: (context, state) {
        final tab = state.params["tab"]!;
        return MainNavigationScreen(tab: tab);
      },
    ),
  ],
);

// final router = GoRouter(
//   routes: [
//     GoRoute(
//       name: SignUpScreen.routeName,
//       path: SignUpScreen.routeURL,
//       builder: (context, state) => const SignUpScreen(),
//       routes: [
//         GoRoute(
//           name: UsernameScreen.routeName,
//           path: UsernameScreen.routeURL,
//           builder: (context, state) => const UsernameScreen(),
//           routes: [
//             GoRoute(
//               path: EmailScreen.routeURL,
//               name: EmailScreen.routeName,
//               builder: (context, state) {
//                 final args = state.extra as EmailScreenArgs;
//                 return EmailScreen(username: args.username);
//               },
//             ),
//           ],
//         ),
//       ],
//     ),
//     // GoRoute(
//     //   path: LoginScreen.routeName,
//     //   builder: (context, state) => const LoginScreen(),
//     // ),
//     /*GoRoute(
//       path: UsernameScreen.routeName,
//       pageBuilder: (context, state) {
//         return CustomTransitionPage(
//           child: const UsernameScreen(),
//           transitionsBuilder: (context, animation, secondaryAnimation, child) {
//             return FadeTransition(
//               opacity: animation,
//               child: ScaleTransition(
//                 scale: animation,
//                 child: child,
//               ),
//             );
//           },
//         );
//       },
//     ),*/

//     GoRoute(
//       path: "/users/:username",
//       builder: (context, state) {
//         final username = state.params['username'];
//         final tab = state.queryParams["show"];
//         return UserProfileScreen(username: username!, tab: tab!);
//       },
//     ),
//   ],
// );
