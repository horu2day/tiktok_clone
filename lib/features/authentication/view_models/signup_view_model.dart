import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpViewModel extends AsyncNotifier {
  @override
  FutureOr build() {}
}

//State를 Widget과 분리
final signUpForm = StateProvider(
  (ref) => {},
);
