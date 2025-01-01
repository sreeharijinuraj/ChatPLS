import 'package:flutter/material.dart';
import 'package:myapp/screens/home_screen_wl.dart';
//import 'home_screen'; // Replace with the actual path of HomeScreenWl

class AppBarAfterLogin extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const AppBarAfterLogin({super.key, required this.title});

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
              onPressed: () {
                // Navigate to HomeScreenWl
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreenWl()),
                );
              },
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
