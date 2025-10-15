import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Carbon_Chillax/screens/onboarding/onboarding_screen.dart';
import 'package:Carbon_Chillax/screens/auth/auth_wrapper.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkOnboardingStatus();
  }

  Future<void> _checkOnboardingStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool seen =  false;
    // bool seen = (prefs.getBool('seenOnboarding') ?? false);

    Timer(Duration(seconds: 3), () {
      if (seen) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => AuthWrapper()),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => OnboardingScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/splash_logo.png', height: 150),
            SizedBox(height: 20),
            Text('Carbon Chillax', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
