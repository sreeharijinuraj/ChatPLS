import 'package:flutter/material.dart';
import 'home_screen_al.dart';
import 'uploadBrochures_screen.dart';
import 'Ai_Chat_screen.dart';
import 'staff_profile_dashboard_screen.dart';

//foradmins
class MainNavigationScreen extends StatefulWidget {
  final String staffName;

  const MainNavigationScreen({
    super.key,
    required this.staffName,
  });

  @override
  _MainNavigationScreenState createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomeScreenAl(staffName: widget.staffName), // Pass staffName properly
      UploadbrochuresScreen(staffName: widget.staffName),
      AiChatScreen(),
      StaffProfileDashboardScreen(
        staffName: widget.staffName,
      ),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
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
            icon: Icon(Icons.),
            label: "AI Chat",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: "Accounts",
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
