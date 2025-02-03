import 'package:flutter/material.dart';
import 'package:myapp/screens/signup_forStaffs_screen.dart';
import 'package:myapp/widgets/AppBar_1.dart';

class ContactadminScreen extends StatelessWidget {
  const ContactadminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9ECC8),
      appBar: const Appbar1(),
      body: Container(
        child: Stack(
          children: [
            Positioned(
                top: 50,
                left: 0,
                right: 0,
                child: Container(
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/CHATPLSLOGO2.png'))),
                )),
            Positioned(
                top: 210,
                left: 0,
                right: 0,
                child: SizedBox(
                    width: 300,
                    height: 60,
                    child: Center(
                      child: Text.rich(
                        TextSpan(children: [
                          TextSpan(
                              text: "Chat",
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .copyWith(color: Color(0xFFFF9F07))),
                          TextSpan(
                              text: "PLS",
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .copyWith(color: Color(0xFFE6AC11)))
                        ]),
                      ),
                    ))),
            Positioned(
                top: 290,
                left: 0,
                right: 0,
                child: SizedBox(
                  width: 340,
                  height: 50,
                  child: Text(
                    "Invalid StaffID",
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(),
                    textAlign: TextAlign.center,
                  ),
                )),
            Positioned(
                top: 335,
                left: 0,
                right: 0,
                child: SizedBox(
                  width: 340,
                  height: 50,
                  child: SizedBox(
                    width: 340,
                    height: 60,
                    child: Text(
                      "Contact administrator for a StaffID at Powerwin.",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )),
            Positioned(
              top: 360,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const SignupForstaffsScreen()),
                          );
                          print("goback  button clicked");
                        },
                        child: Container(
                          width: 100,
                          height: 30,
                          decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              color: Color(0xFFFF9F07)),
                          //color: Color(0xFFF9ECC8),
                          child: Center(
                            child: Text(
                              textAlign: TextAlign.center,
                              "GOBACK",
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .copyWith(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontFamily: 'Saira',
                                    fontWeight: FontWeight.w700,
                                    height: 0.31,
                                  ),
                            ),
                          ),
                        ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
