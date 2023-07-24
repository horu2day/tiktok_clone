import 'package:flutter/material.dart';

class SelectUserScreen extends StatefulWidget {
  static const String routeName = "selectuser";
  static const String routeURL = "/selectuser";
  const SelectUserScreen({super.key});

  @override
  State<SelectUserScreen> createState() => _SelectUserScreenState();
}

class _SelectUserScreenState extends State<SelectUserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        title: const Text('Open Chating Room - Select User'),
      ),
    );
  }
}
