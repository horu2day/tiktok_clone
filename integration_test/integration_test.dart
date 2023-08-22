import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:tiktok_clone/firebase_options.dart';
import 'package:tiktok_clone/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  setUp(() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await FirebaseAuth.instance.signOut();
  });
  testWidgets("Create Account Flow", (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: TikTokApp(),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text("Sign up for TikTok"), findsOneWidget);
    final logIn = find.text("Log in");
    expect(logIn, findsOneWidget);
    await tester.tap(logIn); //글씨를 찾아서 Tap
    await tester.pumpAndSettle(const Duration(seconds: 20)); // 애니메이션처럼 기다리는걸 흉내

    final signUp = find.text("Sign up");
    expect(signUp, findsOneWidget);
  });
}
