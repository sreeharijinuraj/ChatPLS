import 'package:flutter/material.dart';
import 'package:myapp/screens/staff_navigation.dart';
import 'package:myapp/widgets/AppBar_1.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // Supabase package

class LoginForstaffsScreen extends StatefulWidget {
  const LoginForstaffsScreen({super.key});

  @override
  _LoginForstaffsScreenState createState() => _LoginForstaffsScreenState();
}

class _LoginForstaffsScreenState extends State<LoginForstaffsScreen> {
  final TextEditingController _staffIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Form validation key

  // Function to handle login
  Future<void> _login() async {
    if (!_formKey.currentState!.validate())
      return; // If form is invalid, do nothing

    final supabase = Supabase.instance.client;

    final staffId = _staffIdController.text.trim();
    final password = _passwordController.text.trim();

    try {
      // Query to check if the credentials exist in the 'staffs_credentials' table
      final response = await supabase
          .from('staffs_credentials')
          .select('staff_id, password')
          .eq('staff_id', staffId)
          .eq('password',
              password) // Note: password should be hashed in a real scenario
          .single();
      print(response);
      // If the response is valid and credentials match
      if (response != null && response['staff_id'] != null) {
        final staffName = await _getStaffName(staffId);

        // Navigate to the next screen with the staff name
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MainNavigationScreenForStaffs(
              staffName: staffName,
            ),
          ),
        );
      } else {
        // Show error if credentials do not match
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Invalid StaffID or Password")),
        );
      }
    } catch (error) {
      // Handle any errors that occur during the login process
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error logging in: $error")),
      );
    }
  }

  // Function to get the staff's name
  Future<String> _getStaffName(String staffId) async {
    final supabase = Supabase.instance.client;
    final response = await supabase
        .from('staffs')
        .select('name')
        .eq('staff_id', staffId)
        .single();

    return response['name'] ??
        'Unknown'; // Return staff name or 'Unknown' if not found
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9ECC8),
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
                  "Login",
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
                  "Login Back to your Account on ChatPLS.",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 14),
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
                      // StaffID Field
                      TextFormField(
                        controller: _staffIdController,
                        decoration: InputDecoration(
                          hintText: "StaffID",
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
                            return "StaffID cannot be empty";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 8),
                      // Password Field
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Password",
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
                          return null;
                        },
                      ),
                      const SizedBox(height: 8),
                      // Login Button
                      TextButton(
                        onPressed: _login,
                        child: Container(
                          width: 140,
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
                              "LOGIN",
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
            ),
          ],
        ),
      ),
    );
  }
}
