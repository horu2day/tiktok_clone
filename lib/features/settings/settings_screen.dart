import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notifications = false;

  void _onNotificationsChanged(bool? newValue) {
    if (newValue == null) return;
    setState(() {
      _notifications = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          SwitchListTile.adaptive(
            value: _notifications,
            onChanged: _onNotificationsChanged,
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
              print(date);
              final time = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              print(time);
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
              print(booking);
            },
            title: const Text("What is your birthday?"),
          ),
          const AboutListTile(
              applicationVersion: "1.0",
              applicationLegalese: "All rights reserved. Please dont copy me"),
        ],
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