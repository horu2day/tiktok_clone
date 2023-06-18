import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/videos/view_models/playback_config_vm.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //print(Localizations.localeOf(context));
    return Localizations.override(
      context: context,
      locale: const Locale("es"),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        body: ListView(
          children: [
            SwitchListTile.adaptive(
              value: ref.watch(playbackConfigProvider).muted,
              onChanged: (value) =>
                  // playbackConfigProvider.notifier : 난 데이터는 필요없고, notifier클래스에 접근하고 싶어요.
                  ref.read(playbackConfigProvider.notifier).setMuted(value),
              title: const Text("Mute Video"),
              subtitle: const Text("Videos will be muted by default."),
            ),
            SwitchListTile.adaptive(
              value: ref.watch(playbackConfigProvider).autoplay,
              onChanged: (value) =>
                  // playbackConfigProvider.notifier : 난 데이터는 필요없고, notifier클래스에 접근하고 싶어요.
                  ref.read(playbackConfigProvider.notifier).setAutoplay(value),
              title: const Text("Autoplay"),
              subtitle:
                  const Text("Videos will be start playing automatically."),
            ),
            // ValueListenableBuilder(
            //   valueListenable: videoConfig,
            //   builder: (context, value, child) => SwitchListTile.adaptive(
            //     value: value,
            //     onChanged: (value) {
            //       videoConfig.value = !videoConfig.value;
            //     },
            //     title: const Text("Mute video"),
            //     subtitle: const Text("Videos will be muted by default."),
            //   ),
            // ),
            SwitchListTile.adaptive(
              value: false,
              onChanged: (value) => {},
              title: const Text("Enable notifications"),
              subtitle: const Text("Enable notifications"),
            ),
            // CupertinoSwitch(
            //   value: _notifications,
            //   onChanged: _onNotificationsChanged,
            // ),
            // Switch(
            //   value: _notifications,
            //   onChanged: _onNotificationsChanged,
            // ),
            // Checkbox(
            //   value: _notifications,
            //   onChanged: _onNotificationsChanged,
            // ),
            // CheckboxListTile(
            //   checkColor: Colors.yellow,
            //   activeColor: Colors.black,
            //   value: _notifications,
            //   onChanged: _onNotificationsChanged,
            //   title: const Text("Enable notifications"),
            // ),
            ListTile(
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1980),
                  lastDate: DateTime(2030),
                );
                if (kDebugMode) {
                  print(date);
                }

                final time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (kDebugMode) {
                  print(time);
                }

                final booking = await showDateRangePicker(
                  context: context,
                  firstDate: DateTime(1980),
                  lastDate: DateTime(2030),
                  builder: (context, child) {
                    return Theme(
                      data: ThemeData(
                          appBarTheme: const AppBarTheme(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.black)),
                      child: child!,
                    );
                  },
                );
                if (kDebugMode) {
                  print(booking);
                }
              },
              title: const Text("What is your birthday?"),
            ),
            ListTile(
              title: const Text("Log out (iOS)"),
              textColor: Colors.red,
              onTap: () {
                showCupertinoDialog(
                  context: context,
                  builder: (context) => CupertinoAlertDialog(
                    title: const Text("Are you sure?"),
                    content: const Text("Plx dont go"),
                    actions: [
                      CupertinoDialogAction(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text("No"),
                      ),
                      CupertinoDialogAction(
                        onPressed: () => Navigator.of(context).pop(),
                        isDestructiveAction: true,
                        child: const Text("Yes"),
                      ),
                    ],
                  ),
                );
              },
            ),
            ListTile(
              title: const Text("Log out (android)"),
              textColor: Colors.red,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    icon: const FaIcon(FontAwesomeIcons.skull),
                    title: const Text("Are you sure?"),
                    content: const Text("Plx dont go"),
                    actions: [
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const FaIcon(FontAwesomeIcons.car),
                      ),
                      TextButton(
                        onPressed: () {
                          ref.read(authRepo).signOut();
                          context.go("/");
                        }, //Navigator.of(context).pop(),
                        child: const Text("Yes"),
                      ),
                    ],
                  ),
                );
              },
            ),
            ListTile(
              title: const Text("Log out (ios/Bottom)"),
              textColor: Colors.red,
              onTap: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (context) => CupertinoActionSheet(
                    title: const Text("Are you sure?"),
                    message: const Text("Please doonnn goooo"),
                    actions: [
                      CupertinoActionSheetAction(
                        isDefaultAction: true,
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text("Not log out"),
                      ),
                      CupertinoActionSheetAction(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text("Yes plz"),
                      ),
                    ],
                  ),
                );
              },
            ),
            const AboutListTile(
                applicationVersion: "1.0",
                applicationLegalese:
                    "All rights reserved. Please dont copy me"),
          ],
        ),
      ),
    );
  }
}

// Column(
//         children: const [
//           CircularProgressIndicator.adaptive(),
//         ],

// ListWheelScrollView(
//         itemExtent: 200, // Height
//         children: [
//           for (var x in [1, 2, 3, 4, 5, 5, 5, 6, 7, 7, 8, 8, 8, 98, 9])
//             FractionallySizedBox(
//               widthFactor: 1,
//               child: Container(
//                 color: Colors.teal,
//                 alignment: Alignment.center,
//                 child: const Text(
//                   'pick me up',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 39,
//                   ),
//                 ),
//               ),
//             ),
//         ],
//       ),
