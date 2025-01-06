import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:myapp/widgets/AppBar_OfChatScreen.dart';

class AiChatScreen extends StatelessWidget {
  const AiChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9ECC8),
      appBar: const AppbarOfChatScreen(),
      drawer: Drawer(
        backgroundColor: const Color(0xFFFF9F07),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFFFF9F07),
              ),
              child: Column(children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF9ECC8),
                    borderRadius: BorderRadius.circular(30),
                    border:
                        Border.all(color: const Color(0xFFFF9F07), width: 2),
                  ),
                  child: TextField(
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.black,
                          fontSize: 13,
                          fontFamily: 'Saira',
                          fontWeight: FontWeight.w100,
                          height: 4.10),
                      hintText: "Search",
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search, color: Color(0xFFFF9F07)),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    ),
                    onChanged: (value) {},
                  ),
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/images/CHATPLSLOGO2.png',
                      width: 72,
                      height: 72,
                      color: Color(0xFFF9ECC8),
                    ),
                    Text("ChatPLS",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(color: Color(0xFFF9ECC8)))
                  ],
                ),
              ]),
            ),
            const SizedBox(
              height: 5,
            ),
            ListTile(
              title: const Text(
                'Chat - 1',
                style: TextStyle(
                  color: Color(0xFFF9ECC8),
                  fontSize: 18,
                ),
              ),
              onTap: () {
                // Handle Chat - 1 navigation
              },
            ),
            ListTile(
              title: const Text(
                'Chat - 2',
                style: TextStyle(
                  color: Color(0xFFF9ECC8),
                  fontSize: 18,
                ),
              ),
              onTap: () {
                // Handle Chat - 2 navigation
              },
            ),
            ListTile(
              title: const Text(
                'Chat - 3',
                style: TextStyle(
                  color: Color(0xFFF9ECC8),
                  fontSize: 18,
                ),
              ),
              onTap: () {
                // Handle Chat - 3 navigation
              },
            ),
            ListTile(
              title: const Text(
                'Chat - 4',
                style: TextStyle(
                  color: Color(0xFFF9ECC8),
                  fontSize: 18,
                ),
              ),
              onTap: () {
                // Handle Chat - 4 navigation
              },
            ),
          ],
        ),
      ),
      endDrawer: Drawer(
          backgroundColor: const Color(0xFFFF9F07),
          child: Stack(
            children: [
              Positioned(
                  top: 60,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/CHATPLSLOGO2.png',
                        width: 150,
                        height: 150,
                        color: Color(0xFFF9ECC8),
                      ),
                      Text(
                        "ChatPLS",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(color: Color(0xFFF9ECC8), fontSize: 25),
                      )
                    ],
                  )),
              Positioned(
                top: 260,
                left: 10,
                child: Text(
                  "Model Info",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: Color(0xFFF9ECC8), fontSize: 18),
                ),
              ),
              Positioned(
                  top: 280,
                  left: 10,
                  child: Column(
                    children: [
                      Text(
                        "\n\nVersion 1.00",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Color(0xFFF9ECC8),
                            fontSize: 18,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  )),
            ],
          )),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  BubbleNormal(
                    text: "Chat Message -1 (From ChatPLS)",
                    isSender: false,
                    color: const Color(0xFFFF9F07),
                    tail: false,
                    textStyle: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 20, color: const Color(0xFFF9ECC8)),
                  ),
                  BubbleNormal(
                    text: "Chat Message -2 (From Sender)",
                    tail: false,
                    color: const Color(0xFFE6AC11),
                    textStyle: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 20, color: const Color(0xFFF9ECC8)),
                  ),
                  BubbleNormalImage(
                    id: 'id001',
                    image: Image.asset(
                      'assets/images/CHATPLSLOGO2.png',
                      width: 72,
                      height: 72,
                    ),
                    color: const Color(0xFFE6AC11),
                    tail: false,
                  ),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFFF9F07), width: 1),
            ),
            child: MessageBar(
              sendButtonColor: const Color(0xFFFF9F07),
              messageBarHintStyle: const TextStyle(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w400,
              ),
              messageBarHintText: "Message",
              textFieldTextStyle: const TextStyle(
                fontFamily: 'Saira',
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              messageBarColor: const Color(0xFFF9ECC8),
              onSend: (_) {},
              actions: [
                InkWell(
                  child: const Icon(
                    Icons.attach_file,
                    color: Color(0xFFFF9F07),
                    size: 25,
                  ),
                  onTap: () {},
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: InkWell(
                    child: const Icon(
                      Icons.photo_camera,
                      color: Color(0xFFE6AC11),
                      size: 25,
                    ),
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
