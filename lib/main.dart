import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/screens/MainNavigationScreen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
// Initialize shared_preferences
  await SharedPreferences.getInstance();
  try {
    await Supabase.initialize(
      url: 'https://iuqtgadqkslwohenylab.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml1cXRnYWRxa3Nsd29oZW55bGFiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzU3ODY2OTksImV4cCI6MjA1MTM2MjY5OX0.ASZD7OkTI1bN-HmMWN1aRR2Mo_wIBcT6Gg_gACIM0Uo',
    );
  } catch (e) {
    debugPrint('❌ Supabase initialization failed: $e');
  }

  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    debugPrint('⚠️ Flutter Error: ${details.exception}');
  };

  runApp(const ChatPLS());
}

class ChatPLS extends StatelessWidget {
  const ChatPLS({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChatPLS',
      theme: ThemeData(
        textTheme: TextTheme(
          displayLarge: GoogleFonts.saira(
            color: Colors.black,
            fontSize: 35,
            fontWeight: FontWeight.w600,
            height: 1.2, // Adjusted for better spacing
          ),
          titleLarge: GoogleFonts.saira(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w500,
            height: 1.3,
          ),
          bodyMedium: GoogleFonts.saira(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w200,
            height: 1.4,
          ),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFF9ECC8)),
        useMaterial3: true,
      ),
      home: const MainNavigationScreen(),
    );
  }
}
