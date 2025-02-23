import 'package:flutter/material.dart';
import 'home_screen_al.dart';
import 'uploadBrochures_screen.dart';
import 'Ai_Chat_screen.dart';
import 'staff_profile_dashboard_screen.dart';

// for admins
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
  final ValueNotifier<Image?> _aiChatIcon = ValueNotifier<Image?>(null);

  @override
  void initState() {
    super.initState();
    _pages = [
      HomeScreenAl(staffName: widget.staffName),
      UploadbrochuresScreen(staffName: widget.staffName),
      AiChatScreen(staffName: widget.staffName),
      StaffProfileDashboardScreen(staffName: widget.staffName),
    ];
    _loadAiChatIcon();
  }

  Future<void> _loadAiChatIcon() async {
    try {
      final image =
          Image.asset("assets/images/CHATPLSLOGO2.png", width: 33, height: 33);
      await precacheImage(image.image, context);
      _aiChatIcon.value = image;
    } catch (e) {
      debugPrint("Error loading AI Chat icon: $e");
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void dispose() {
    _aiChatIcon.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFFFF9F07),
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.upload),
            label: "Upload",
          ),
          BottomNavigationBarItem(
            icon: ValueListenableBuilder<Image?>(
              valueListenable: _aiChatIcon,
              builder: (context, image, child) {
                return image ??
                    const SizedBox(
                        width: 33, height: 33, child: Icon(Icons.chat));
              },
            ),
            label: "AI Chat",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: "Accounts",
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: const Color(0xFFF9ECC8),
        selectedItemColor: Colors.black,
        unselectedIconTheme: const IconThemeData(size: 33),
        onTap: _onItemTapped,
      ),
    );
  }
}
