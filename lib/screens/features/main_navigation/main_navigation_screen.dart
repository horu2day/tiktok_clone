import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/screens/features/main_navigation/stf_screen.dart';
import 'package:tiktok_clone/screens/features/main_navigation/widgets/nav_tab.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  // var screens = [
  //   const Center(
  //     child: Text(
  //       'Home',
  //       style: TextStyle(fontSize: 49),
  //     ),
  //   ),
  //   const Center(
  //     child: Text(
  //       'Discover',
  //       style: TextStyle(fontSize: 49),
  //     ),
  //   ),
  //   const Center(
  //     child: Text(
  //       'Home',
  //       style: TextStyle(fontSize: 49),
  //     ),
  //   ),
  //   const Center(
  //     child: Text(
  //       'Inbox',
  //       style: TextStyle(fontSize: 49),
  //     ),
  //   ),
  //   const Center(
  //     child: Text(
  //       'Profile',
  //       style: TextStyle(fontSize: 49),
  //     ),
  //   ),
  // ];

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Offstage(
          offstage: _selectedIndex != 0,
          child: const StfScreen(Offstage()),
        ),
        Offstage(
          offstage: _selectedIndex != 1,
          child: const StfScreen(Offstage()),
        ),
        // Opacity(
        //   opacity: _selectedIndex != 2 ? 0 : 1,
        //   child: Container(
        //     alignment: Alignment.center,
        //     child: const Text(
        //       'Center',
        //       style: TextStyle(fontSize: Sizes.size40),
        //     ),
        //   ),
        // ),
        Offstage(
          offstage: _selectedIndex != 3,
          child: const StfScreen(Offstage()),
        ),
        Offstage(
          offstage: _selectedIndex != 4,
          child: const StfScreen(Offstage()),
        ),
      ]),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(Sizes.size12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NavTab(
                text: "Home",
                isSelected: _selectedIndex == 0,
                icon: FontAwesomeIcons.house,
                selectedIcon: FontAwesomeIcons.house,
                onTap: () => _onTap(0),
              ),
              NavTab(
                text: "Discover",
                isSelected: _selectedIndex == 1,
                icon: FontAwesomeIcons.compass,
                selectedIcon: FontAwesomeIcons.solidCompass,
                onTap: () => _onTap(1),
              ),
              Gaps.h24,
              Stack(
                children: [
                  Positioned(
                    right: 20,
                    child: Container(
                      height: 30,
                      width: 25,
                      padding: const EdgeInsets.symmetric(
                        horizontal: Sizes.size8,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(
                            Sizes.size11,
                          )),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    child: Container(
                      height: 30,
                      width: 25,
                      padding: const EdgeInsets.symmetric(
                        horizontal: Sizes.size8,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(
                            Sizes.size11,
                          )),
                    ),
                  ),
                  Container(
                    height: 30,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: const FaIcon(
                      FontAwesomeIcons.plus,
                    ),
                  )
                ],
              ),
              NavTab(
                text: "Inbox",
                isSelected: _selectedIndex == 3,
                icon: FontAwesomeIcons.message,
                selectedIcon: FontAwesomeIcons.solidMessage,
                onTap: () => _onTap(3),
              ),
              NavTab(
                text: "Profile",
                isSelected: _selectedIndex == 4,
                icon: FontAwesomeIcons.user,
                selectedIcon: FontAwesomeIcons.solidUser,
                onTap: () => _onTap(4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
