import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/features/videos/video_recording_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const VideoRecordingScreen(),
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
