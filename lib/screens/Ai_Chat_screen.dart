import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:myapp/widgets/AppBar_OfChatScreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AiChatScreen extends StatefulWidget {
  const AiChatScreen({super.key});

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen> {
  List<Map<String, dynamic>> chatMessages = [];
  bool isLoading = false;
  void _simulateTyping(String fullText) async {
    setState(() {
      chatMessages.add({'isSender': false, 'text': ''});
    });

    int index = chatMessages.length - 1;
    for (int i = 0; i < fullText.length; i++) {
      await Future.delayed(const Duration(milliseconds: 30)); // Speed of typing
      setState(() {
        chatMessages[index]['text'] += fullText[i];
      });
    }
  }

  Future<void> sendQuery(String query) async {
    final url = Uri.parse('http://192.168.0.112:5000/search');
    try {
      setState(() {
        isLoading = true;
      });

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'query': query}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        print("API Response: $data"); // Debugging

        // Check if the 'response' field exists and is valid
        if (data.containsKey('response') && data['response'] is String) {
          _simulateTyping(data['response']); // Display AI response
        } else {
          _simulateTyping("No relevant response received.");
        }
      } else {
        _simulateTyping(
            "Error from server. Status Code: ${response.statusCode}");
      }
    } catch (e) {
      print('Error: $e');
      _simulateTyping(
          "Failed to fetch response due to network or server issues.");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

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
              child: Column(
                children: [
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
                        prefixIcon:
                            Icon(Icons.search, color: Color(0xFFFF9F07)),
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
                        color: const Color(0xFFF9ECC8),
                      ),
                      Text("ChatPLS",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(color: const Color(0xFFF9ECC8))),
                    ],
                  ),
                ],
              ),
            ),
            const ListTile(
              title: Text(
                'Chat - 1',
                style: TextStyle(
                  color: Color(0xFFF9ECC8),
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: chatMessages.length,
              itemBuilder: (context, index) {
                final message = chatMessages[index];
                return Align(
                  alignment: message['isSender']
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Row(
                      mainAxisAlignment: message['isSender']
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      children: [
                        // Add the icon for response messages
                        if (!message['isSender'])
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Image.asset(
                              'assets/images/CHATPLSLOGO2.png',
                              width: 30,
                              height: 30,
                            ),
                          ),
                        // Message container
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 22, horizontal: 10),
                            decoration: BoxDecoration(
                              color: message['isSender']
                                  ? const Color(
                                      0xFFFF9F07) // Sender's message color
                                  : const Color(
                                      0xFFF9ECC8), // Receiver's message color
                              borderRadius:
                                  BorderRadius.circular(20), // Rounded corners
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    textAlign: TextAlign.start,
                                    softWrap: true,
                                    maxLines: null,
                                    message['text'].replaceAll("\n\n",
                                        ""), // Remove unnecessary newlines
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      fontFamily:
                                          'Saira', // Ensure only 'Saira' font is used
                                      color: message['isSender']
                                          ? Colors
                                              .white // Set sender message text color
                                          : Color(
                                              0xFFFF9F07), // Set receiver message text color
                                      height: 1.7, // Set proper text height
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          if (isLoading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
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
              onSend: (message) async {
                setState(() {
                  chatMessages.add({'isSender': true, 'text': message});
                });
                await sendQuery(message);
              },
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
