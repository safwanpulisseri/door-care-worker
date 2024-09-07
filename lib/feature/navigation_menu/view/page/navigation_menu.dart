import 'package:doorcareworker/feature/booking/view/page/booking.dart';
import 'package:doorcareworker/feature/home/view/page/home.dart';
import 'package:doorcareworker/core/theme/color/app_color.dart';
import 'package:flutter/material.dart';

import '../../../drawer/home_drawer.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _HomeNavigationMenuState();
}

class _HomeNavigationMenuState extends State<NavigationMenu> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const HomePage(),
    const BookingPage(),
  ];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: AppColor.primary,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_rounded),
            label: '',
          ),
        ],
      ),
    );
  }
}
