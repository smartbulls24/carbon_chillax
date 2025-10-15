import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:Carbon_Chillax/screens/auth/login_screen.dart';
import 'package:Carbon_Chillax/screens/home_screen.dart';

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    if (firebaseUser != null) {
      return HomeScreen();
    } else {
      return LoginScreen();
    }
  }
}
