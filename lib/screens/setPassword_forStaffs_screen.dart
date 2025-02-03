import 'package:flutter/material.dart';
import 'package:myapp/screens/staff_navigation.dart';
import 'package:myapp/widgets/AppBar_1.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // Supabase package
import 'package:async/async.dart';

class SetpasswordForstaffsScreen extends StatefulWidget {
  final String staffId; // Receiving StaffID from previous screen

  const SetpasswordForstaffsScreen({super.key, required this.staffId});

  @override
  _SetpasswordForstaffsScreenState createState() =>
      _SetpasswordForstaffsScreenState();
}

class _SetpasswordForstaffsScreenState
    extends State<SetpasswordForstaffsScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Form validation key

  Future<void> _setPassword() async {
    if (!_formKey.currentState!.validate()) return;

    final supabase = Supabase.instance.client;

    try {
      // Insert the password into the "staff_credentials" table
      await supabase.from('staffs_credentials').insert({
        'staff_id': widget.staffId, // Store StaffID from previous screen
        'password':
            _passwordController.text, // Store plain text (hash it for security)
      });

      // Fetch the staff name from the "staffs" table using the staffId
      final response = await supabase
          .from('staffs')
          .select('name')
          .eq('staff_id', widget.staffId)
          .single();

      // Check if we got a valid response
      if (response != null && response['name'] != null) {
        final staffName = response['name'];

        // Navigate to the next screen and pass the staff name
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MainNavigationScreenForStaffs(
              staffName: staffName,
            ),
          ),
        );
      } else {
        // Handle error if staff name is not found
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: Staff name not found")),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error setting password: $error")),
      );
    }
  }

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
                    image: AssetImage('assets/images/CHATPLSLOGO2.png'),
                  ),
                ),
              ),
            ),
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
                            .copyWith(color: Color(0xFFFF9F07)),
                      ),
                      TextSpan(
                        text: "PLS",
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(color: Color(0xFFE6AC11)),
                      )
                    ]),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 265,
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
              ),
            ),
            Positioned(
              top: 320,
              left: 0,
              right: 0,
              child: SizedBox(
                width: 340,
                height: 50,
                child: Text(
                  "You're a Staff at Powerwin, Set a Password for your Account.",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Positioned(
              top: 350,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
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
                            borderSide:
                                BorderSide(color: Color(0xFFFF9F07), width: 2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xFFFF9F07), width: 2.5),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password cannot be empty";
                          }
                          if (value.length < 8) {
                            return "Password must be at least 8 characters";
                          }
                          if (!RegExp(
                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                              .hasMatch(value)) {
                            return "Password must include upper, lower, number & special character";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: true,
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
                            borderSide:
                                BorderSide(color: Color(0xFFFF9F07), width: 2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xFFFF9F07), width: 2.5),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        validator: (value) {
                          if (value != _passwordController.text) {
                            return "Passwords do not match";
                          }
                          return null;
                        },
                      ),
                      TextButton(
                        onPressed: _setPassword,
                        child: Container(
                          width: 190,
                          height: 30,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            color: Color(0xFFFF9F07),
                          ),
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
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
