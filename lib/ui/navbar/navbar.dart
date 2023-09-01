import 'package:flutter/material.dart';
import 'package:wildlife_surveillance/ui/navbar/settings.dart';

import '../camera.dart';
import 'gallery.dart';
import 'history.dart';
import 'homepage.dart';

class navbar extends StatefulWidget {
  const navbar({super.key});

  @override
  State<navbar> createState() => _navbarState();
}

class _navbarState extends State<navbar> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static  List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    GalleryPage(),
    ActivityMonitoringPage(),
    settings(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.home,size: 30,),label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.camera,size: 30),label: 'Camera'),
        BottomNavigationBarItem(icon: Icon(Icons.history,size: 30),label: 'Activity'),
        BottomNavigationBarItem(icon: Icon(Icons.settings,size: 30),label: 'Settings'),
      ],
      currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromRGBO(255, 143, 0, 1),
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: TextStyle(fontFamily: 'PT Sans'),
        unselectedLabelStyle: TextStyle(fontFamily: 'PT Sans'),
        showUnselectedLabels: true,
        onTap: _onItemTapped,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      
    );
  }
}