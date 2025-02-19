import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';

class SplashScreenController extends NyController {
  void navigateToSignUp(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, "/sign-up");
      }
    });
  }
}
