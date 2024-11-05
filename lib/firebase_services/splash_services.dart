import 'dart:async';

import 'package:demo_firebase/UI/auth/login_screen.dart';
import 'package:demo_firebase/UI/posts/post_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class SplashServices {

  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    // Check if user is logged in
    if (user != null) {
      // Navigate to PostScreen after 1 second
      Timer(const Duration(seconds: 1), () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => PostScreen()),
                (route) => false // Remove all previous routes
        );
      });
    } else {
      // Navigate to LoginScreen after 3 seconds
      Timer(const Duration(seconds: 3), () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
                (route) => false // Remove all previous routes
        );
      });
    }
  }

}