import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class MyNavbar extends StatefulWidget {
  const MyNavbar({super.key});

  @override
  State<MyNavbar> createState() => _MyNavbarState();
}

class _MyNavbarState extends State<MyNavbar> {
  int myIndex = 0;
  @override
  Widget build(BuildContext context) {
    return AnimatedBottomNavigationBar(
      icons: const [
        Icons.home,
        Icons.settings,
      ],
      backgroundColor: const Color.fromARGB(255, 94, 35, 253),
      height: 64,
      activeColor: Colors.white,
      inactiveColor: Colors.white.withOpacity(0.4),
      activeIndex: myIndex,
      gapLocation: GapLocation.center,
      notchSmoothness: NotchSmoothness.smoothEdge,
      leftCornerRadius: 32,
      rightCornerRadius: 32,
      onTap: (index) {
        setState(() {
          myIndex = index;
        });
      },
    );
  }
}
