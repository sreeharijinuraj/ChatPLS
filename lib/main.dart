import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/screens/contactAdmin_screen.dart';
import 'package:myapp/screens/login_forAdmin_screen.dart';
import 'package:myapp/screens/login_forStaffs_screen.dart';
import 'package:myapp/screens/setPassword_forStaffs_screen.dart';
//import 'package:myapp/screens/home_screen_wl.dart';
import 'package:myapp/screens/signup_forStaffs_screen.dart';
//import 'package:myapp/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        textTheme: TextTheme(

            //For Large Headings and other..(Text Theme)
            displayLarge: GoogleFonts.saira(
                color: Colors.black,
                fontSize: 35,
                fontWeight: FontWeight.w600,
                height: 0.04),

            //For Medium Headings and other..(Text Theme)

            titleLarge: GoogleFonts.saira(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w500,
                height: 0.13),

                //For Small Headings and other..(Text Theme)

            bodyMedium: GoogleFonts.saira(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w200,
                height: 0.20)
                ),

        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0XF9ECC8)
          ),
        useMaterial3: true,
      ),
      home: const LoginForadminScreen(),
    );
  }
}
