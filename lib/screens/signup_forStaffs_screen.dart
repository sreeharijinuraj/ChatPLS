import 'package:flutter/material.dart';
import 'package:myapp/widgets/AppBar_1.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'setPassword_forStaffs_screen.dart';
import 'contactAdmin_screen.dart';

class SignupForstaffsScreen extends StatefulWidget {
  const SignupForstaffsScreen({super.key});

  @override
  _SignupForstaffsScreenState createState() => _SignupForstaffsScreenState();
}

class _SignupForstaffsScreenState extends State<SignupForstaffsScreen> {
  final supabase = Supabase.instance.client; // Initialize Supabase client

  final TextEditingController staffIdController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Future<void> verifyStaff() async {
    final staffID = staffIdController.text.trim();
    final name = nameController.text.trim();
    final email = emailController.text.trim();

    if (staffID.isEmpty || name.isEmpty || email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter all fields')),
      );
      return;
    }

    // Query Supabase to check if the staff exists
    final response = await supabase
        .from('staffs')
        .select()
        .eq('staff_id', staffID)
        .eq('name', name)
        .eq('email', email)
        .maybeSingle(); // Returns null if no match is found

    if (response != null) {
      print("Staff Exists , Moving to SetPasswordScreen");

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SetpasswordForstaffsScreen(staffId: staffID)),
      );
    } else {
      // Staff does not exist, navigate to ContactAdminScreen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ContactadminScreen()),
      );
    }
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
                  decoration: const BoxDecoration(
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
                top: 265,
                left: 0,
                right: 0,
                child: SizedBox(
                  width: 340,
                  height: 50,
                  child: Text(
                    "Getting Started.",
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
                    "Signup for a free account. Find Products easily.",
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: staffIdController,
                        decoration: InputDecoration(
                            hintText: "StaffID",
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
                                borderRadius: BorderRadius.circular(15)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(0xFFFF9F07), width: 2.5),
                              borderRadius: BorderRadius.circular(15),
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Staff ID is required';
                          }
                          if (value != value.toUpperCase()) {
                            return 'Staff ID must be in uppercase';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                            hintText: "Name",
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
                                borderRadius: BorderRadius.circular(15)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(0xFFFF9F07), width: 2.5),
                              borderRadius: BorderRadius.circular(15),
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Name is required';
                          }
                          if (RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]')
                              .hasMatch(value)) {
                            return 'Name should not contain numbers or special symbols';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                            hintText: "E-mail",
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
                                borderRadius: BorderRadius.circular(15)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(0xFFFF9F07), width: 2.5),
                              borderRadius: BorderRadius.circular(15),
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is required';
                          }
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(value)) {
                            return 'Enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 8),
                      TextButton(
                          onPressed: verifyStaff,
                          child: Container(
                            width: 140,
                            height: 30,
                            decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                color: const Color(0xFFFF9F07)),
                            child: Center(
                              child: Text(
                                textAlign: TextAlign.center,
                                "VERIFY",
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
                          )),
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
