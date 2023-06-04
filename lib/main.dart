import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tiktok_clone/common/video_configuration/video_config.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/router.dart';

import 'generated/l10n.dart';

void main() async {
  //1. 초기화시 모든걸 묶는다.
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  // SystemChrome.setSystemUIOverlayStyle(
  //   SystemUiOverlayStyle.light,
  // );
  runApp(const TikTokApp());
}

class TikTokApp extends StatelessWidget {
  const TikTokApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    S.load(const Locale("en"));
    return VideoConfig(
      child: MaterialApp.router(
        routerConfig: router,
        debugShowCheckedModeBanner: true,
        title: 'TikTok Clone',
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale("en"),
          Locale("ko"),
        ],
        themeMode: ThemeMode.system,
        theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.light,
          textTheme: Typography.blackMountainView,
          //  구글폰트 사용법
          // textTheme: GoogleFonts.itimTextTheme(),
          scaffoldBackgroundColor: Colors.white,
          primaryColor: const Color(0xffe9435a),
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Color(0xffe9435a),
          ),
          splashColor: Colors.transparent,
          //highlightColor: Colors.transparent,
          appBarTheme: const AppBarTheme(
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            elevation: 0,
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: Sizes.size16 + Sizes.size2,
              fontWeight: FontWeight.w600,
            ),
          ),
          bottomAppBarTheme: BottomAppBarTheme(
            color: Colors.grey.shade100,
          ),
          tabBarTheme: TabBarTheme(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey.shade500,
            //indicatorColor: Colors.black,
            indicator: const UnderlineTabIndicator(
              borderSide: BorderSide(
                width: 2.0,
                color: Colors.black,
              ),
            ),
          ),
          listTileTheme: const ListTileThemeData(
            iconColor: Colors.black,
          ),
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          tabBarTheme: TabBarTheme(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey.shade700,
            indicator: const UnderlineTabIndicator(
              borderSide: BorderSide(
                width: 2.0,
                color: Colors.white,
              ),
            ),
          ),
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Color(0xffe9435a),
          ),
          brightness: Brightness.dark,
          textTheme: Typography.whiteMountainView,
          // textTheme: GoogleFonts.itimTextTheme(
          //   ThemeData(brightness: Brightness.dark).textTheme,
          // ),
          scaffoldBackgroundColor: Colors.black,
          primaryColor: const Color(0xffe9435a),
          appBarTheme: AppBarTheme(
            surfaceTintColor: Colors.grey.shade900,
            backgroundColor: Colors.grey.shade900,
            titleTextStyle: const TextStyle(
              color: Colors.white,
              fontSize: Sizes.size16 + Sizes.size2,
              fontWeight: FontWeight.w600,
            ),
            actionsIconTheme: IconThemeData(
              color: Colors.grey.shade100,
            ),
            iconTheme: IconThemeData(
              color: Colors.grey.shade100,
            ),
          ),
          bottomAppBarTheme: BottomAppBarTheme(
            color: Colors.grey.shade900,
          ),
        ),
        // go_router 쓰지않을때
        // initialRoute: SignUpScreen.routeName, //시작하는 home 을 말함.
        // routes: {
        //   SignUpScreen.routeName: (context) => const SignUpScreen(),
        //   UsernameScreen.routeName: (context) => const UsernameScreen(),
        //   LoginScreen.routeName: (context) => const LoginScreen(),
        //   EmailScreen.routeName: (context) => const EmailScreen()
        // },
        //최초
        //home: const InterestsScreen(),
        //home: const SignUpScreen(),
        //home: const SettingsScreen(),
        //home: const MainNavigationScreen(),
        //home: const LayoutBuilderCodeLab(),
      ),
    );
  }
}

// class LayoutBuilderCodeLab extends StatelessWidget {
//   const LayoutBuilderCodeLab({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Scaffold(
//       body: SizedBox(
//         width: size.width / 2,
//         child: LayoutBuilder(
//           builder: (context, constraints) => Container(
//             width: constraints.maxWidth,
//             height: constraints.maxHeight,
//             color: Colors.teal,
//             child:
//                 Center(child: Text("${size.width} / ${constraints.maxWidth} ")),
//           ),
//         ),
//       ),
//     );
//   }
// }

// 텍스트 Theme
// textTheme: TextTheme(
//           displayLarge: GoogleFonts.openSans(
//               fontSize: 96, fontWeight: FontWeight.w300, letterSpacing: -1.5),
//           displayMedium: GoogleFonts.openSans(
//               fontSize: 60, fontWeight: FontWeight.w300, letterSpacing: -0.5),
//           displaySmall:
//               GoogleFonts.openSans(fontSize: 48, fontWeight: FontWeight.w400),
//           headlineMedium: GoogleFonts.openSans(
//               fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25),
//           headlineSmall:
//               GoogleFonts.openSans(fontSize: 24, fontWeight: FontWeight.w400),
//           titleLarge: GoogleFonts.openSans(
//               fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
//           titleMedium: GoogleFonts.openSans(
//               fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
//           titleSmall: GoogleFonts.openSans(
//               fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
//           bodyLarge: GoogleFonts.roboto(
//               fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
//           bodyMedium: GoogleFonts.roboto(
//               fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
//           labelLarge: GoogleFonts.roboto(
//               fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
//           bodySmall: GoogleFonts.roboto(
//               fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
//           labelSmall: GoogleFonts.roboto(
//               fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
//         ),
