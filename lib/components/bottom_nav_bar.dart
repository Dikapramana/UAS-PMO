import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

// ignore: must_be_immutable
class MyBottomNavBar extends StatelessWidget {
  void Function(int)? onTabChange;
  MyBottomNavBar({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(25),
      child: GNav(
        onTabChange: (value) => onTabChange!(value),
        color: Colors.grey[400],
        mainAxisAlignment: MainAxisAlignment.center,
        activeColor: Colors.grey[700],
        tabBackgroundColor: Colors.grey.shade300,
        tabBorderRadius: 24,
        tabActiveBorder: Border.all(color: Colors.deepOrangeAccent),
        tabs: const [
          GButton(
            icon: Icons.coffee_outlined,
            text: 'Coffe',
          ),
          GButton(
            icon: Icons.bakery_dining_outlined,
            text: 'Bread',
          ),
          GButton(
            icon: Icons.camera_alt_outlined,
            text: 'Camera',
          ),
        ],
      ),
    );
  }
}
