import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_application_1/ui/addserviceitems/addservice.dart';
import 'package:flutter_application_1/ui/home/home.dart';
import 'package:flutter_application_1/ui/profile/profile.dart';

class NaviBar extends StatefulWidget {
  const NaviBar({super.key});

  @override
  State<NaviBar> createState() => _NaviBarState();
}

class _NaviBarState extends State<NaviBar> {
  int _selectedIndex = 1; // Default index to Profile page

  final List<Widget> _screens = [
    const Home(),
    Addservice(),
    const Profile(), 
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex], // Show the selected screen
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedIndex,
        items: const <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.add, size: 30),
          Icon(Icons.person, size: 30),
          
        ],
        color: Colors.purpleAccent,
        buttonBackgroundColor: Colors.purpleAccent,
        backgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _selectedIndex = index; // Update the selected index
          });
        },
      ),
    );
  }
}