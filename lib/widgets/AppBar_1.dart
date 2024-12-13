import 'package:flutter/material.dart';

class Appbar1 extends StatelessWidget implements PreferredSizeWidget {
  const Appbar1({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          print("Button Clicked");
        },
        icon: Icon(
          Icons.arrow_back,
          color: Color(0xFFFF9F07),
        ),
      ),
      title: Row(
        children: [
          Image.asset(
            'assets/images/CHATPLSLOGO2.png',
            width: 72,
            height: 72,
          ),
          const SizedBox(width: 10), // Spacing between the image and text
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
      backgroundColor:
          Colors.transparent, // Optional: Makes the AppBar transparent
      elevation: 0, // Optional: Removes shadow for a flat design
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
