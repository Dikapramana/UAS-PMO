import 'package:aplikasi_online/components/bottom_nav_bar.dart';
import 'package:aplikasi_online/main.dart';
import 'package:aplikasi_online/screens/Bread.dart';
import 'package:aplikasi_online/screens/CameraPage.dart';
import 'package:aplikasi_online/screens/Coffe.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //navigate bottom bar
  int _selectedIndex = 0;
  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  //Screen
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      //Coffee screen
      CoffeePage(),

      //Bread screen
      BreadPage(),

      //Camera Screen
      TakePictureScreen(camera: cameras.first),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: MyBottomNavBar(
        onTabChange: (index) => navigateBottomBar(index),
      ),
      body: _pages[_selectedIndex],
    );
  }
}
