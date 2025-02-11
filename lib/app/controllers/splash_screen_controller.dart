import 'package:dandaily/resources/pages/login_page.dart';
import 'package:flutter/material.dart';
import '/app/controllers/controller.dart';

class SplashScreenController extends Controller {
  void navigateToHome(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, LoginPage.path);
      }
    });
  }
}
