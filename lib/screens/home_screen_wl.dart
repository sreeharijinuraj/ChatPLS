import 'package:flutter/material.dart';
import 'package:myapp/widgets/AppBar_1.dart';

class HomeScreenWl extends StatelessWidget {
  const HomeScreenWl({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar1(),
      body: Container(
        child: Stack(
          children: [
            Positioned(
                top: 35,
                left: 20,
                child: Text.rich(TextSpan(children: [
                  TextSpan(
                      text: "Make Your \nLighting Better By \nUsing ",
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          height: 1.5,
                          fontSize: 30)),
                  TextSpan(
                      text: "Chat",
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge!
                          .copyWith(color: Color(0xFFFF9F07), height: 1.5)),
                  TextSpan(
                      text: "PLS.",
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge!
                          .copyWith(color: Color(0xFFE6AC11), height: 1.5)),
                ]))),
            Positioned(
                top: 190,
                left: 20,
                child: Text(
                  "Finding Products is now easier with ChatPLS.",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
                )),

            //The "Positioned Widget of the Orange Rounded Rectangle Starts from here"

            Positioned(
                top: 220,
                left: 0,
                right: 0,
                child: Container(
                  decoration: ShapeDecoration(
                      color: Color(0xFFFF9F07),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                  height: MediaQuery.of(context).size.height - 220,
                ))

            //The "Positioned Widget of the Orange Rounded Rectangle Ends here"
          ],
        ),
      ),
    );
  }
}
