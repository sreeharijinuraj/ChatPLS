import 'package:flutter/material.dart';

import 'home_screen_al.dart'; // Replace with the actual path
import 'uploadBrochures_screen.dart'; // Replace with the actual path
import 'Ai_Chat_screen.dart'; // Replace with the actual path
import 'staff_profile_dashboard_screen.dart'; // Replace with the actual path

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  _MainNavigationScreenState createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  // List of pages corresponding to each tab
  final List<Widget> _pages = [
    HomeScreenAl(), // Replace with your HomeScreen class
    UploadbrochuresScreen(), // Replace with your UploadbrochuresScreen class
    AiChatScreen(), // Replace with your AIChat class
    StaffProfileDashboardScreen(), // Replace with your StaffProfileDashboardScreen class
  ];

  // Handle bottom navigation bar item taps
  void _onItemTapped(int index) {
      print("Selected Index: $index");
    setState(() {
      _selectedIndex = index;
    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Display the selected page
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xFFFF9F07),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.upload),
            label: "Upload",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: "AI Chat",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: "Account",
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Color(0xFFF9ECC8),
        selectedItemColor: Colors.black,
        unselectedIconTheme: IconThemeData(size: 33),
        onTap: _onItemTapped,
      ),
    );
  }
}
