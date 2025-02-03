import 'package:flutter/material.dart';
import 'package:myapp/screens/home_screen_wl.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
// Declare staffName as a parameter

  const SplashScreen({super.key}); // Provide a default value

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Delay for 3 seconds and then navigate to the main screen
    Timer(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomeScreenWl(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9ECC8),
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
            bottom: 60,
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
