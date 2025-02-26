import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppbarOfChatScreen extends StatefulWidget implements PreferredSizeWidget {
  const AppbarOfChatScreen({super.key});

  @override
  State<AppbarOfChatScreen> createState() => _AppbarOfChatScreenState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppbarOfChatScreenState extends State<AppbarOfChatScreen> {
  String staffName = "Loading...";

  @override
  void initState() {
    super.initState();
    _fetchStaffName();
  }

  Future<void> _fetchStaffName() async {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;

    if (user != null) {
      debugPrint("User ID: ${user.id}"); // Debugging: Print user ID

      final response = await supabase
          .from('staffs')
          .select('name')
          .eq('staff_id', user.id)
          .maybeSingle();

      debugPrint("Supabase Response: $response"); // Debugging: Print response

      if (response != null && response['name'] != null) {
        setState(() {
          staffName = response['name'];
        });
      } else {
        setState(() {
          staffName = "Unknown";
        });
      }
    } else {
      setState(() {
        staffName = "Guest";
      });
    }
  }

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
            _showReportDialog(context);
          },
          icon: const Icon(Icons.report_gmailerrorred_rounded,
              color: Color(0xFFFF9F07)),
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

  void _showReportDialog(BuildContext context) {
    final TextEditingController reportController = TextEditingController();
    final supabase = Supabase.instance.client;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFFF9ECC8),
          title: Text(
            "Report an Issue",
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: const Color(0xFFFF9F07)),
          ),
          content: TextField(
            controller: reportController,
            maxLines: 5,
            decoration: const InputDecoration(
              hintStyle: TextStyle(
                  fontFamily: 'Saira',
                  fontStyle: FontStyle.italic,
                  fontSize: 14),
              hintText: "Describe your issue regarding the chat...",
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                String reportText = reportController.text.trim();

                if (reportText.isNotEmpty) {
                  try {
                    await supabase.from('chat_reports').insert({
                      'staff_name': staffName, // Use fetched staff name
                      'report_text': reportText,
                      'reported_at': DateTime.now().toIso8601String(),
                    });

                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text("Report added successfully.")),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Error: $e")),
                    );
                  }
                }
              },
              child: const Text("Send"),
            ),
          ],
        );
      },
    );
  }
}
