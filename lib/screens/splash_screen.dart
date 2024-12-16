import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Center(
                  child: Image.asset(
                    'assets/images/CHATPLSLOGO2.png',
                    width: 263,
                    height: 229,
                  ),
                ),
              ),
              Text.rich(TextSpan(children: [
                TextSpan(
                    text: "Chat",
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge!
                        .copyWith(color: Color(0xFFFF9F07), fontSize: 40)),
                TextSpan(
                    text: "PLS",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Color(0xFFE6AC11), fontSize: 40))
              ])),
            ],
          ),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Text(
              "AI CHATBOT BUILT FOR POWERWIN",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .displayLarge!
                  .copyWith(color: Color(0xFFE6AC11), fontSize: 17),
            ),
          ),
        ],
      ),
    );
  }
}
