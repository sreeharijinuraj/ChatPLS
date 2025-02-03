import 'package:flutter/material.dart';
import 'home_screen_al.dart';
import 'Ai_Chat_screen.dart';
import 'staff_profile_dashboard_forstaffonly.dart';

class MainNavigationScreenForStaffs extends StatefulWidget {
  final String staffName; // Add a field to hold the staff name

  const MainNavigationScreenForStaffs({
    super.key,
    required this.staffName,
  });

  @override
  _MainNavigationScreenForStaffsState createState() =>
      _MainNavigationScreenForStaffsState();
}

class _MainNavigationScreenForStaffsState
    extends State<MainNavigationScreenForStaffs> {
  int _selectedIndex = 0;

  // Handle bottom navigation bar item taps
  void _onItemTapped(int index) {
    print("Selected Index: $index");
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // List of pages corresponding to each tab
    final List<Widget> _pages = [
      HomeScreenAl(
          staffName: widget.staffName), // Correct usage of widget.staffName
      AiChatScreen(),
      StaffProfileDashboardForstaffonly(
        staffName: widget.staffName,
      ),
    ];

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
            icon: Icon(Icons.add),
            label: "AI Chat",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: "Profile",
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
