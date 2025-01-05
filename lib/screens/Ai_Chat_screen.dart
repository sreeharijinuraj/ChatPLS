import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:myapp/widgets/AppBar_OfChatScreen.dart';

class AiChatScreen extends StatelessWidget {
  const AiChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9ECC8),
      appBar: AppbarOfchatscreen(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  BubbleNormal(
                    text: "Chat Message -1 (From ChatPLS)",
                    isSender: false,
                    color: Color(0xFFFF9F07),
                    tail: false,
                    textStyle: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 20, color: Color(0xFFF9ECC8)),
                  ),
                  BubbleNormal(
                    text: "Chat Message -2 (From Sender)",
                    tail: false,
                    color: Color(0xFFE6AC11),
                    textStyle: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 20, color: Color(0xFFF9ECC8)),
                  ),
                  BubbleNormalImage(
                    // User sends the image
                    id: 'id001',
                    image: Image.asset(
                      'assets/images/CHATPLSLOGO2.png',
                      width: 72,
                      height: 72,
                    ),
                    color: Color(0xFFE6AC11),
                    tail: false,
                  ),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFFFF9F07), width: 1),
            ),
            child: MessageBar(
              sendButtonColor: Color(0xFFFF9F07),
              messageBarHintStyle: TextStyle(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w400,
              ),
              messageBarHintText: "Message",
              textFieldTextStyle: TextStyle(
                fontFamily: 'Saira',
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              messageBarColor: Color(0xFFF9ECC8),
              onSend: (_) {},
              actions: [
                InkWell(
                  child: Icon(
                    Icons.attach_file,
                    color: Color(0xFFFF9F07),
                    size: 25,
                  ),
                  onTap: () {},
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8, right: 8),
                  child: InkWell(
                    child: Icon(
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
