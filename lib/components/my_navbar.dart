import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class MyNavbar extends StatelessWidget {
  final int currentIndex; // Menerima index dari WidgetTree
  final Function(int) onTap; // Callback ke WidgetTree

  const MyNavbar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

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
      activeIndex: currentIndex, // Gunakan index dari WidgetTree
      gapLocation: GapLocation.center,
      notchSmoothness: NotchSmoothness.smoothEdge,
      leftCornerRadius: 32,
      rightCornerRadius: 32,
      onTap: onTap, // Panggil fungsi di WidgetTree
    );
  }
}
