import 'package:flutter/material.dart';
import 'package:snapbit/utils/constants.dart';
import 'package:snapbit/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snapbit/onboarding/onboarding_screen_flow.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool onboardingComplete = prefs.getBool('onboardingComplete') ?? false;

    runApp(MyApp(onboardingComplete: onboardingComplete));
}

class MyApp extends StatelessWidget {
  const MyApp
  (
    { super.key, 
      required this.onboardingComplete
    }
  );

    final bool onboardingComplete;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SnapBite',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.robotoTextTheme().copyWith(
          bodyMedium: textFont.copyWith(fontSize: 16, color: Colors.white),
          bodyLarge: textFont.copyWith(fontSize: 18, color: Colors.white),
          bodySmall: textFont.copyWith(fontSize: 14, color: Colors.white),
          headlineLarge: textFont.copyWith(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          headlineSmall: textFont.copyWith(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          labelLarge: textFont.copyWith(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
          labelMedium: textFont.copyWith(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
          labelSmall: textFont.copyWith(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white),
          titleLarge: textFont.copyWith(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
          titleMedium: textFont.copyWith(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          titleSmall: textFont.copyWith(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      initialRoute: onboardingComplete ? '/login' : '/',
      routes: {
        '/': (context) => const OnboardingScreenFlow(),
        '/login': (context) => const LoginScreen(),
      },
    );
  }
}

