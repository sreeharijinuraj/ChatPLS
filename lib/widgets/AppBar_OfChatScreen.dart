import 'package:flutter/material.dart';

class AppbarOfchatscreen extends StatelessWidget
    implements PreferredSizeWidget {
  const AppbarOfchatscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFF9ECC8),
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          // Add functionality for menu button
        },
        icon: const Icon(Icons.menu, color: Color(0xFFFF9F07)),
      ),
      centerTitle: true,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/CHATPLSLOGO2.png',
            width: 60,
            height: 60,
          ),
          const SizedBox(width: 8), // Add spacing between logo and text
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "Chat",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: const Color(0xFFFF9F07)),
                ),
                TextSpan(
                  text: "PLS",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: const Color(0xFFE6AC11)),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {
            // Add functionality for + icon
          },
          icon: const Icon(Icons.add, color: Color(0xFFFF9F07)),
        ),
        IconButton(
          onPressed: () {
            // Add functionality for 3-dot menu icon
          },
          icon: const Icon(Icons.more_vert, color: Color(0xFFFF9F07)),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
