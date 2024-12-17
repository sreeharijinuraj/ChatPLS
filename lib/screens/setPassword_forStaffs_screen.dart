import 'package:flutter/material.dart';
import 'package:myapp/widgets/AppBar_1.dart';

class SetpasswordForstaffsScreen extends StatelessWidget {
  const SetpasswordForstaffsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    "Set Password",
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(),
                    textAlign: TextAlign.center,
                  ),
                )),
            Positioned(
                top: 320,
                left: 0,
                right: 0,
                child: SizedBox(
                  width: 340,
                  height: 50,
                  child: Text(
                    "You're a Staff at Powerwin,Set a Password for \n\n\n\nyour Account.",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                )),
            Positioned(
              top: 350,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                          hintText: "New Password",
                          hintStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontFamily: 'Saira',
                            fontWeight: FontWeight.w100,
                            height: 0.31,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 6,
                            horizontal: 8,
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFFFF9F07), width: 2),
                              borderRadius: BorderRadius.circular(15)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xFFFF9F07), width: 2.5),
                            borderRadius:
                                BorderRadius.circular(15), // Rounded corners
                          )),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      decoration: InputDecoration(
                          hintText: "Confirm Password",
                          hintStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontFamily: 'Saira',
                            fontWeight: FontWeight.w100,
                            height: 0.31,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 6,
                            horizontal: 8,
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFFFF9F07), width: 2),
                              borderRadius: BorderRadius.circular(15)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xFFFF9F07), width: 2.5),
                            borderRadius:
                                BorderRadius.circular(15), // Rounded corners
                          )),
                    ),
                                      TextButton(
                        onPressed: () {
                          print("SETPASSWORD button clicked");
                        },
                        child: Container(
                          width: 190,
                          height: 30,
                          decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              color: Color(0xFFFF9F07)),
                          //color: Color(0xFFF9ECC8),
                          child: Center(
                            child: Text(
                              textAlign: TextAlign.center,
                              "SET PASSWORD & SIGNIN",
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
                        ))],
                ),
              ),
            )
          ],
        ),
      ),);
  }
}