import 'package:flutter/material.dart';
import 'package:myapp/widgets/AppBar_1.dart';
import 'package:footer/footer.dart';
import 'package:footer/footer_view.dart';
import 'package:myapp/screens/login_forAdmin_screen.dart';
import 'package:myapp/screens/signup_forStaffs_screen.dart';
import 'package:myapp/screens/login_forStaffs_screen.dart';

class HomeScreenWl extends StatefulWidget {
  const HomeScreenWl({super.key});

  @override
  State<HomeScreenWl> createState() => _HomeScreenWlState();
}

class _HomeScreenWlState extends State<HomeScreenWl> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9ECC8),
      appBar: const Appbar1(),
      body: Stack(
        children: [
          // Background and Text
          Positioned(
            top: 35,
            left: 20,
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "Make Your \nLighting Better By \nUsing ",
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        height: 1.5,
                        fontSize: 30),
                  ),
                  TextSpan(
                    text: "Chat",
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge!
                        .copyWith(color: Color(0xFFFF9F07), height: 1.5),
                  ),
                  TextSpan(
                    text: "PLS.",
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge!
                        .copyWith(color: Color(0xFFE6AC11), height: 1.5),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 175,
            left: 20,
            child: Text(
              "Finding Products is now easier with ChatPLS.",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
            ),
          ),

          // Orange Background Container
          Positioned(
            top: 220,
            left: 0,
            right: 0,
            child: IgnorePointer(
              child: Container(
                decoration: ShapeDecoration(
                  color: Color(0xFFFF9F07),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                height: MediaQuery.of(context).size.height - 220,
              ),
            ),
          ),

          // "Get Started" Text
          Positioned(
            top: 245,
            left: 0,
            right: 0,
            child: SizedBox(
              child: Text(
                "Get Started.",
                style: Theme.of(context).textTheme.displayLarge,
                textAlign: TextAlign.center,
              ),
            ),
          ),

          // Buttons: SIGNUP, LOGIN, LOGIN FOR ADMIN
          Positioned(
            top: 300, // Adjusted to ensure buttons are not overlapped
            left: 0,
            right: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    print("Navigating to Signup Screen"); // Debugging
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignupForstaffsScreen()),
                    );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Color(0xFFF9ECC8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: _buildButton(
                      "SIGNUP", Theme.of(context).textTheme.titleLarge!),
                ),
                const SizedBox(height: 10), // Added spacing between buttons
                TextButton(
                  onPressed: () {
                    print("Navigating to Login Screen"); // Debugging
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginForstaffsScreen()),
                    );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Color(0xFFF9ECC8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: _buildButton(
                      "LOGIN", Theme.of(context).textTheme.titleLarge!),
                ),
                const SizedBox(height: 10), // Added spacing between buttons
                TextButton(
                  onPressed: () {
                    print("Navigating to Admin Login Screen"); // Debugging
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginForadminScreen()),
                    );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Color(0xFFF9ECC8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: _buildButton("LOGIN FOR ADMIN",
                      Theme.of(context).textTheme.titleLarge!),
                ),
              ],
            ),
          ),

          // "How to Use?" Section
          Positioned(
            top: 520, // Adjusted to ensure it doesn't overlap buttons
            left: 0,
            right: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 350,
                  height: 180,
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
                        children: [
                          Icon(Icons.login, color: Color(0xFFFF9F07), size: 45),
                          Icon(Icons.search,
                              color: Color(0xFFE6AC11), size: 45),
                          Icon(Icons.accessibility_new,
                              color: Color(0xFFFF9F07), size: 45),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildStepText(
                            "Step 1 : Login",
                          ),
                          _buildStepText("Step 2 : Search"),
                          _buildStepText("Step 3 : Results"),
                        ],
                      ),
                      const SizedBox(height: 7),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildDescriptionText(
                              "Login with your ID& \nPassword"),
                          _buildDescriptionText("Search with Images/\nText"),
                          _buildDescriptionText("Find Products From\n ChatPLS"),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text, TextStyle style) {
    return Container(
      width: 300,
      height: 48,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Color(0xFFF9ECC8),
      ),
      child: Center(
        child: Text(
          textAlign: TextAlign.center,
          text,
          style: style,
        ),
      ),
    );
  }

  Widget _buildStepText(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildDescriptionText(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: Colors.black,
          fontSize: 10,
          fontFamily: 'Saira',
          fontWeight: FontWeight.w400,
          height: 0),
    );
  }
}
