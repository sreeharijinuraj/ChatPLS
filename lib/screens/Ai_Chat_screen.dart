import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:myapp/widgets/AppBar_OfChatScreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class AiChatScreen extends StatefulWidget {
  final String staffName;

  const AiChatScreen({super.key, required this.staffName});

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class FadeIconButton extends StatefulWidget {
  final Icon icon;
  final VoidCallback onTap;

  const FadeIconButton({super.key, required this.icon, required this.onTap});

  @override
  State<FadeIconButton> createState() => _FadeIconButtonState();
}

//buttonfadeeffect
class _FadeIconButtonState extends State<FadeIconButton> {
  double _opacity = 1.0;

  void _handleTap() async {
    setState(() => _opacity = 0.5); // Fade out
    await Future.delayed(const Duration(milliseconds: 150));
    setState(() => _opacity = 1.0); // Fade back in
    widget.onTap(); // Trigger the original onTap
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 150),
        opacity: _opacity,
        child: widget.icon,
      ),
    );
  }
}

class _AiChatScreenState extends State<AiChatScreen> {
  List<Map<String, dynamic>> chatMessages = [];
  List<Map<String, dynamic>> chatList = [];
  bool isLoading = false;
  final SupabaseClient supabase = Supabase.instance.client;
  String chatId = "";
  double fabX = 300;
  double fabY = 600;
  @override
  void initState() {
    super.initState();
    _loadChatList().then((_) {
      if (chatList.isNotEmpty) {
        chatId = chatList.first['chat_id']; // Set first chat as default
        _loadChats(chatId);
      }
    });
  }

  Future<void> _loadChatList() async {
    final response = await supabase
        .from('chats')
        .select('chat_id, staff_name, created_at')
        .eq('staff_name', widget.staffName)
        .order('created_at', ascending: false);

    print("Chat list response: $response"); // Debug log

    final Set<String> uniqueChatIds = {};
    List<Map<String, dynamic>> uniqueChats = [];

    for (var chat in response) {
      if (!uniqueChatIds.contains(chat['chat_id'])) {
        uniqueChatIds.add(chat['chat_id']);
        uniqueChats.add(chat);
      }
    }

    setState(() {
      chatList = uniqueChats;
    });

    print("Loaded ${chatList.length} chats for staff: ${widget.staffName}");

    // Automatically load first chat
    if (chatList.isNotEmpty) {
      setState(() {
        chatId = chatList.first['chat_id'];
      });
      _loadChats(chatId);
    }
  }

  Future<void> _loadChats(String chatId) async {
    print("Loading messages for chat ID: $chatId"); // Debug log

    final response = await supabase
        .from('chats')
        .select()
        .eq('chat_id', chatId)
        .order('created_at', ascending: true);

    print("Chat messages response: $response"); // Debug log

    setState(() {
      chatMessages = response
          .map((chat) => {
                'isSender': chat['is_sender'],
                'text': chat['message'],
                'chat_id': chat['chat_id']
              })
          .toList();
    });

    print("Loaded ${chatMessages.length} messages");
  }

  Future<void> _startNewChat() async {
    String newChatId = const Uuid().v4();
    await supabase.from('chats').insert({
      'staff_name': widget.staffName,
      'chat_id': newChatId,
      'message': 'Starting A New Chat',
      'is_sender': true,
      'created_at': DateTime.now().toUtc().toIso8601String(),
    });
    setState(() {
      chatId = newChatId;
      chatMessages = [];
    });
    await _loadChatList();
  }

  Future<void> _saveChat(String message, bool isSender) async {
    if (chatId.isEmpty) {
      chatId = const Uuid().v4();
    }

    await supabase.from('chats').insert({
      'staff_name': widget.staffName,
      'chat_id': chatId,
      'message': message,
      'is_sender': isSender,
      'created_at':
          DateTime.now().toUtc().toIso8601String(), // Ensure timestamp is added
    });
  }

  void _simulateTyping(String fullText) async {
    setState(() {
      chatMessages.add({'isSender': false, 'text': ''});
    });

    int index = chatMessages.length - 1;
    for (int i = 0; i < fullText.length; i++) {
      await Future.delayed(const Duration(milliseconds: 30));
      setState(() {
        chatMessages[index]['text'] += fullText[i];
      });
    }

    // Save only once at the end
    await _saveChat(fullText, false);
  }

  Future<void> _deleteChat(String chatId) async {
    await supabase.from('chats').delete().eq('chat_id', chatId);
    await _loadChatList(); // Refresh chat list after deletion
  }

  Future<void> sendQuery(String query) async {
    setState(() {
      isLoading = true;
      chatMessages.add({'isSender': true, 'text': query});
    });

    await _saveChat(query, true);

    final url = Uri.parse(isWebSearchEnabled
        ? 'http://192.168.0.100:5000/web_search_chat'
        : 'http://192.168.0.100:5000/search');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'query': query}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Server response: $data');

        // This is the key change - properly extract the response from either endpoint
        if (data.containsKey('response')) {
          _simulateTyping(data['response']);
        } else {
          _simulateTyping("No relevant response received.");
        }
      } else {
        _simulateTyping(
            "Error from server. Status Code: ${response.statusCode}");
      }
    } catch (e) {
      _simulateTyping(
          "Failed to fetch response due to network or server issues: ${e.toString()}");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    if (source == ImageSource.camera) {
      var status = await Permission.camera.request();
      if (status != PermissionStatus.granted) {
        _simulateTyping("Camera permission denied.");
        return;
      }
    } else if (source == ImageSource.gallery) {
      var status =
          await Permission.photos.request(); // Correct API for Android 13+
      if (status.isDenied || status.isPermanentlyDenied) {
        _simulateTyping("Gallery access permission denied.");
        return;
      }
    }

    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);

    if (image != null) {
      File imageFile = File(image.path);
      setState(() {
        chatMessages.add(
            {'isSender': true, 'text': '[Image Attached]', 'image': imageFile});
      });
      await _sendImage(imageFile);
    }
  }

  Future<void> _sendImage(File imageFile) async {
    final url = Uri.parse('http://192.168.0.100:5000/search_image');

    try {
      setState(() {
        isLoading = true;
      });

      var request = http.MultipartRequest('POST', url);
      request.files
          .add(await http.MultipartFile.fromPath('image', imageFile.path));

      final response = await request.send();
      final responseData = await response.stream.bytesToString();
      print("Full Response Data: $responseData");

      if (response.statusCode == 200) {
        final data = jsonDecode(responseData);
        print("Parsed JSON: $data");

        if (data.containsKey("matches") && data["matches"].isNotEmpty) {
          final metadata = data["matches"][0]["exif_metadata"];
          _simulateTyping(
              metadata != null ? metadata.toString() : "No metadata found.");
        } else {
          _simulateTyping("No relevant results found.");
        }
      } else {
        _simulateTyping(
            "Error from server. Status Code: ${response.statusCode}");
      }
    } catch (e) {
      _simulateTyping(
          "Failed to fetch response due to network or server issues.");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  //websearch function
  bool isWebSearchEnabled = false;

  void toggleWebSearch(BuildContext context) async {
    setState(() {
      isWebSearchEnabled = !isWebSearchEnabled;
    });

    final message =
        isWebSearchEnabled ? 'Web Search is Now Enabled' : 'Web Search is Off';

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.blue,
        content: Text(
          message,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
        ),
      ),
    );

    // Send the toggle status to Flask
    await http.post(
      Uri.parse('http://192.168.0.100:5000/toggle_web_search'),
      body: {'enabled': isWebSearchEnabled.toString()},
    );
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
                  )
                ],
              ),
            ),
            ListTile(
              leading:
                  const Icon(Icons.library_add, color: const Color(0xFFF9ECC8)),
              title: Text(
                "New Chat",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: const Color(0xFFF9ECC8)),
              ),
              onTap: () async {
                await _startNewChat();
                Navigator.pop(context); // Close drawer after creating chat
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ...chatList.map(
              (chat) => ListTile(
                leading: IconButton(
                  icon: const Icon(Icons.visibility, color: Color(0xFFF9ECC8)),
                  onPressed: () {
                    setState(() {
                      chatId = chat['chat_id'];
                    });
                    _loadChats(chat['chat_id']);
                  },
                ),
                title: Text(
                  "Chat ID: ${chat['chat_id'].substring(0, 8)}...",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: const Color(0xFFF9ECC8), fontSize: 18),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline_rounded,
                      color: Colors.red),
                  onPressed: () async {
                    await _deleteChat(chat['chat_id']);
                  },
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
                                  // Conditional rendering based on whether the image is attached
                                  if (message['image'] != null)
                                    Image.file(
                                        message['image']) // Display the image
                                  else
                                    Text(
                                      message['text'].replaceAll("\n\n",
                                          ""), // Remove unnecessary newlines
                                      textAlign: TextAlign.start,
                                      softWrap: true,
                                      maxLines: null,
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
                await sendQuery(message);
              },
              actions: [
                FadeIconButton(
                  icon: const Icon(Icons.attach_file,
                      color: Color(0xFFFF9F07), size: 25),
                  onTap: () => _pickImage(ImageSource.gallery),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: FadeIconButton(
                    icon: const Icon(Icons.photo_camera,
                        color: Color(0xFFE6AC11), size: 25),
                    onTap: () => _pickImage(ImageSource.camera),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: FadeIconButton(
                    icon: Icon(
                      Icons.language_sharp,
                      color:
                          isWebSearchEnabled ? Colors.green : Colors.blueAccent,
                      size: 25,
                    ),
                    onTap: () => toggleWebSearch(context),
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
