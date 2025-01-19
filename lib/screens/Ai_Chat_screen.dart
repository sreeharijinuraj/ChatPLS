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

  Future<void> sendQuery(String query) async {
    final url = Uri.parse('http://192.168.0.110:5000/search');
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
        final results = data['results'] as List;

        if (results.isEmpty) {
          setState(() {
            chatMessages.add({
              'isSender': false,
              'text': 'No matching results found in the database.'
            });
          });
        } else {
          for (var result in results) {
            final content = result['content'];
            final fileName = result['file_name'];
            final similarity = result['similarity'];

            setState(() {
              chatMessages.add({
                'isSender': false,
                'text':
                    'Match: $fileName\n\n\n\n\nContent: $content\n\n\n\n\n\n\n\n\n\n\nSimilarity: $similarity\n\n\n\n\n\n',
              });
            });
          }
        }
      } else {
        setState(() {
          chatMessages.add({'isSender': false, 'text': 'Error from server.'});
        });
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        chatMessages
            .add({'isSender': false, 'text': 'Failed to fetch response.'});
      });
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
                                    message['text'],
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: message['isSender']
                                          ? const Color(
                                              0xFFF9ECC8) // Text color for sender
                                          : const Color(
                                              0xFF000000), // Text color for receiver
                                      fontFamily: 'Saira',
                                    ),
                                  ),
                                  if (!message['isSender'] &&
                                      message['text'].contains('Match:')) ...[
                                    const SizedBox(height: 5),
                                    Text(
                                      "Certainly! Here's the result From ChatPLS:\n\n\n",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      message['text'].replaceAll("\n\n", ""),
                                      style: const TextStyle(
                                        height: 1.5,
                                      ),
                                    ),
                                  ],
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
