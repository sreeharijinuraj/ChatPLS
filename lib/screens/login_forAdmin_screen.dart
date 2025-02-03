import 'package:flutter/material.dart';
import 'package:myapp/screens/MainNavigationScreen.dart';
import 'package:myapp/widgets/AppBar_1.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginForadminScreen extends StatefulWidget {
  const LoginForadminScreen({super.key});

  @override
  _LoginForadminScreenState createState() => _LoginForadminScreenState();
}

class _LoginForadminScreenState extends State<LoginForadminScreen> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final SupabaseClient supabase = Supabase.instance.client;

  Future<void> _loginAdmin() async {
    String adminId = _idController.text.trim();
    String password = _passwordController.text.trim();

    if (adminId.isEmpty || password.isEmpty) {
      _showError("Please enter both ID and Password");
      return;
    }

    try {
      final response = await supabase
          .from('staffs_credentials')
          .select('staff_id, password')
          .eq('staff_id', adminId)
          .single();

      if (response == null) {
        _showError("Invalid ID or Password");
      } else {
        String correctPassword = response['password'];
        if (password == correctPassword) {
          final staffResponse = await supabase
              .from('staffs')
              .select('name')
              .eq('staff_id', adminId)
              .single();

          if (staffResponse != null) {
            String staffName = staffResponse['name'];
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MainNavigationScreen(
                  staffName: staffName,
                ),
              ),
            );
          } else {
            _showError("Staff not found in database");
          }
        } else {
          _showError("Invalid ID or Password");
        }
      }
    } catch (error) {
      _showError("Login failed. Try again.");
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9ECC8),
      appBar: const Appbar1(),
      body: Stack(
        children: [
          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: Container(
              width: 160,
              height: 160,
              decoration: const BoxDecoration(
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
                          .copyWith(color: const Color(0xFFFF9F07)),
                    ),
                    TextSpan(
                      text: "PLS",
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge!
                          .copyWith(color: const Color(0xFFE6AC11)),
                    ),
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
                "Login For Admin",
                style: Theme.of(context).textTheme.displayLarge,
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
                "Login for Administrator.",
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: _idController,
                    decoration: InputDecoration(
                      hintText: "ID",
                      hintStyle: const TextStyle(
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
                        borderSide: const BorderSide(
                            color: Color(0xFFFF9F07), width: 2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color(0xFFFF9F07), width: 2.5),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Password",
                      hintStyle: const TextStyle(
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
                        borderSide: const BorderSide(
                            color: Color(0xFFFF9F07), width: 2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color(0xFFFF9F07), width: 2.5),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: _loginAdmin,
                    child: Container(
                      width: 140,
                      height: 30,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        color: const Color(0xFFFF9F07),
                      ),
                      child: Center(
                        child: Text(
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
        ],
      ),
    );
  }
}
