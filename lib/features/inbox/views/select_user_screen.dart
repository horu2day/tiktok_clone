import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/inbox/view_models/select_user_view_model.dart';

class SelectUserScreen extends ConsumerStatefulWidget {
  static const String routeName = "selectuser";
  static const String routeURL = "/selectuser";
  const SelectUserScreen({super.key});

  @override
  ConsumerState<SelectUserScreen> createState() => _SelectUserScreenState();
}

class _SelectUserScreenState extends ConsumerState<SelectUserScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    //ref.read(selectUsersModelProvider.notifier).fetchUsers();
    return ref.watch(selectUsersModelProvider).when(
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          error: (error, stackTrace) => Center(
            child: Text(
              'Could not load users: $error',
              style: const TextStyle(color: Colors.white),
            ),
          ),
          data: (users) {
            return Scaffold(
              appBar: AppBar(
                elevation: 1,
                centerTitle: true,
                title: const Text('Select User'),
              ),
              body: GestureDetector(
                onTap: () => {},
                child: Stack(
                  children: [
                    Scrollbar(
                      controller: _scrollController,
                      child: ListView.separated(
                        controller: _scrollController,
                        padding: const EdgeInsets.only(
                          top: Sizes.size10,
                          bottom: Sizes.size96 + Sizes.size20,
                          left: Sizes.size16,
                          right: Sizes.size16,
                        ),
                        separatorBuilder: (context, index) => Gaps.v20,
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          final userData = users[index];
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 18,
                                backgroundColor: Colors.black,
                                foregroundColor: Colors.white,
                                foregroundImage: userData.hasAvatar
                                    ? NetworkImage(
                                        "https://firebasestorage.googleapis.com/v0/b/tictok-kms6600.appspot.com/o/avatar%2F${userData.uid}?alt=media&token=24efe12b-aac6-4ff1-ae73-cdbc4a5fd3c5")
                                    : null,
                                child: Text(userData.name),
                              ),
                              Gaps.h10,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      userData.name,
                                      style: TextStyle(
                                        fontSize: Sizes.size14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey.shade500,
                                      ),
                                    ),
                                    Gaps.v3,
                                    Text(userData.bio),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
  }
}
