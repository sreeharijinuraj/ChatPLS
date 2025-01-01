import 'package:flutter/material.dart';
import 'package:myapp/widgets/AppBar_2_AfterLogin.dart';

class HomeScreenAl extends StatelessWidget {
  const HomeScreenAl({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppBarAfterLogin(title: "Home-AI"),
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
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
              top: 290,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  // "Hey There!.." with rounded orange container
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 249, 239),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/CHATPLSLOGO2.png',
                              width: 60,
                              height: 60,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Hey There!..",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontSize: 25, color: Color(0xFFE6AC11)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  // "Hello Chatpls" with rounded container
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFE6AC11),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        child: Text(
                          "I'm Your AI Assistant..!",textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
