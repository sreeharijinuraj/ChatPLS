import 'package:flutter/material.dart';
import 'package:myapp/widgets/AppBar_1.dart';
import 'package:footer/footer.dart';
import 'package:footer/footer_view.dart';

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
            ,
            Positioned(
                top: 260,
                left: 0,
                right: 0,
                child: SizedBox(
                  child: Text(
                    "Get Started.",
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(),
                    textAlign: TextAlign.center,
                  ),
                )),

            //THE 3 BUTTONS STARTS FROME HERE SUCH AS SIGNUP.LOGIN...ETC

            Positioned(
                top: 300,
                left: 0,
                right: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          print("SINGUP button clicked");
                        },
                        child: Container(
                          width: 300,
                          height: 48,
                          decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              color: Color(0xFFF9ECC8)),
                          //color: Color(0xFFF9ECC8),
                          child: Center(
                            child: Text(
                              textAlign: TextAlign.center,
                              "SIGNUP",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(),
                            ),
                          ),
                        )),
                    TextButton(
                        onPressed: () {
                          print("LOGIN button clicked");
                        },
                        child: Container(
                          width: 300,
                          height: 48,
                          decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              color: Color(0xFFF9ECC8)),
                          //color: Color(0xFFF9ECC8),
                          child: Center(
                            child: Text(
                              textAlign: TextAlign.center,
                              "LOGIN",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(),
                            ),
                          ),
                        )),
                    TextButton(
                        onPressed: () {
                          print("LOGINFORADMIN button clicked");
                        },
                        child: Container(
                          width: 300,
                          height: 48,
                          decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              color: Color(0xFFF9ECC8)),
                          //color: Color(0xFFF9ECC8),
                          child: Center(
                            child: Text(
                              textAlign: TextAlign.center,
                              "LOGIN FOR ADMIN",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(),
                            ),
                          ),
                        ))
                  ],
                )),

            //THE 3 BUTTONS ends HERE SUCH AS SIGNUP.LOGIN...ETC

            Positioned(
              top: 520,
              left: 0,
              right: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 350,
                    height: 150,
                    decoration: ShapeDecoration(
                      color: Color(0xFFF9ECC8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 11),
                          child: Text(
                            "How to Use?",
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(fontSize: 30),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const <Widget>[
                            Icon(
                              Icons.login,
                              color: Color(0xFFFF9F07),
                              size: 45,
                            ),
                            Icon(
                              Icons.search,
                              color: Color(0xFFE6AC11),
                              size: 45,
                            ),
                            Icon(
                              Icons.accessibility_new,
                              color: Color(0xFFFF9F07),
                              size: 45,
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Step 1 : Login",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontFamily: 'Saira',
                                      fontWeight: FontWeight.w600,
                                      height: 0.52),
                            ),
                            Text(
                              "Step 2 : Search",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontFamily: 'Saira',
                                      fontWeight: FontWeight.w600,
                                      height: 0.52),
                            ),
                            Text(
                              "Step 3 : Results",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontFamily: 'Saira',
                                      fontWeight: FontWeight.w600,
                                      height: 0.52),
                            )
                          ],
                        ),
                        const SizedBox(height: 7),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Login with your ID& \nPassword",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: Colors.black,
                                      fontSize: 10,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      height: 0),
                            ),
                            Text(
                              "Search with Images/\nText",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: Colors.black,
                                      fontSize: 10,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      height: 0),
                            ),
                            Text(
                              "Find Products From\n ChatPLS",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: Colors.black,
                                      fontSize: 10,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      height: 0),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),

            //Footer Positioned Widget
            Positioned(
                child: FooterView(
              children: <Widget>[],
              footer: Footer(
                backgroundColor: Color(0xFFFF9F07),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    "© 2025,All Rights Reserved-Powered By SH",
                    style: TextStyle(color: Color(0xFFF9ECC8)),
                  ),
                ),
                padding: EdgeInsets.all(10),
              ),
              flex: 1,
            ))
          ],
        ),
      ),
    );
  }
}
