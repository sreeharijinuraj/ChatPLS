import 'package:flutter/material.dart';

class AppbarOfChatScreen extends StatelessWidget
    implements PreferredSizeWidget {
  const AppbarOfChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFF9ECC8),
      elevation: 0,
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(Icons.menu, color: Color(0xFFFF9F07)),
          );
        },
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
          const SizedBox(width: 8),
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
        PopupMenuButton(
          icon: const Icon(Icons.more_vert, color: Color(0xFFFF9F07)),
          color: const Color(0xFFFF9F07),
          itemBuilder: (BuildContext context) => [
            PopupMenuItem(
              value: 'about',
              child: Row(
                children: [
                  const Icon(Icons.info, color: Color(0xFFF9ECC8)),
                  const SizedBox(width: 8),
                  Text(
                    'About',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: const Color(0xFFF9ECC8)),
                  ),
                ],
              ),
            ),
          ],
          onSelected: (value) {
            if (value == 'about') {
              Scaffold.of(context).openEndDrawer();
            }
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
