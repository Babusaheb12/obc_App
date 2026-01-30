
import 'package:flutter/material.dart';

import '../../screen/Accessories/Accessories.dart';
import '../../screen/PreownedCar/PreownedCar.dart';
import '../../screen/Spares/Spares.dart';
import '../../screen/TyreAlloys/TyreAlloys.dart';
import '../../screen/dashboard/Dashboard.dart';
import 'BottomNavigationBar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    MyDashboardScreenPage(),
    MySparesScreenPage(),
    MyAccessoriesScreenPage(),
    MyTyreAlloysScreenPage(),
    MyPreownedCarScreenPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],   // 🔥 page change yahan ho raha
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}






