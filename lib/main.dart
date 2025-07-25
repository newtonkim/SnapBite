import 'package:flutter/material.dart';
import 'package:snapbit/utils/constants.dart';
import 'package:snapbit/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snapbit/onboarding/onboarding_screen_flow.dart';

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
        textTheme: TextTheme(
          bodyMedium: textFont,
          bodyLarge: textFont,
          bodySmall: textFont,
          headlineMedium: textFont,
          headlineLarge: textFont,
          headlineSmall: textFont,
          labelLarge: textFont,
          labelMedium: textFont,
          labelSmall: textFont,
          titleLarge: textFont,
          titleMedium: textFont,
          titleSmall: textFont,
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

