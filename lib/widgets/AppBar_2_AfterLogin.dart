import 'package:flutter/material.dart';
import 'package:myapp/screens/home_screen_wl.dart'; // Replace with the correct path

class AppBarAfterLogin extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const AppBarAfterLogin({super.key, required this.title});

  // Function to log out the user (clear session or authentication data)
  void _logout(BuildContext context) {
    // Assuming you have a method to clear the user session or any authentication state
    // Example: AuthService.logout(); (Clear any auth state, tokens, etc.)

    // Show the confirmation dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Logout"),
          content: Text("Are you sure you want to log out?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                // Perform logout and navigate to HomeScreenWl
                // You can replace the below line with your actual logout method
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreenWl()),
                );
              },
              child: Text("Logout"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/CHATPLSLOGO2.png',
                  width: 72,
                  height: 72,
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Chat",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: Color(0xFFFF9F07)),
                      ),
                      TextSpan(
                        text: "PLS",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: Color(0xFFE6AC11)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 10,
            right: 0,
            child: TextButton(
              onPressed: () =>
                  _logout(context), // Trigger logout on button press
              child: Text(
                "Logout?",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Color(0xFFFF9F07),
                      fontWeight: FontWeight.w300,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
