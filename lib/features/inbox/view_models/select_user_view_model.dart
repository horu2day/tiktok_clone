import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/inbox/repos/users_repo.dart';
import 'package:tiktok_clone/features/users/models/user_profile_model.dart';

class SelectUserViewModel extends AsyncNotifier<List<UserProfileModel>> {
  late final UsersRepo _repo;
  List<UserProfileModel> _list = [];
  @override
  FutureOr<List<UserProfileModel>> build() async {
    _repo = ref.read(usersRepo);
    _list = await _fetchUsers();
    return _list;
  }

  Future<List<UserProfileModel>> _fetchUsers() async {
    final result = await _repo.fetchUsers();
    final users = result.docs.map(
      (doc) => UserProfileModel.fromJson(
        doc.data(),
      ),
    );

    return users.toList();
  }
}

final selectUsersModelProvider =
    AsyncNotifierProvider<SelectUserViewModel, List<UserProfileModel>>(
  () => SelectUserViewModel(),
);
