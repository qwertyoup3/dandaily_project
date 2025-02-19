import 'package:dandaily/service/auth_service.dart';
import 'package:dandaily/config/assets_image.dart';
import 'package:dandaily/config/colors_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';

class SignUpPage extends NyStatefulWidget {
  static RouteView path = ("/sign-up", (context) => SignUpPage());

  SignUpPage({super.key}) : super(child: () => _SignUpPageState());
}

class _SignUpPageState extends NyPage<SignUpPage> {
  @override
  get init => () {};

  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerPassword2 = TextEditingController();
  User? user;

  signUpUser() async {
    if (controllerEmail.text.isNotEmpty && controllerPassword.text.isNotEmpty) {
      user = await FirebaseAuthService().signUpUser(
        email: controllerEmail.text.trim(),
        password: controllerPassword.text.trim(),
      );
    }
    if (user != null && mounted) {
      Navigator.pushNamed(context, "/sign-in");
    }
  }

  @override
  Widget view(BuildContext context) {
    return Scaffold(
      backgroundColor: SetColors.secondaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Dandaily Logo Image
              const SizedBox(height: 100),
              SizedBox(
                width: 300,
                height: 150,
                child: Image.asset(AssetImages.dandailyGreenLogo),
              ),

              // Title
              const Text(
                'Let’s get started!',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: SetColors.primaryColor,
                ),
              ),
              const SizedBox(height: 55),

              // Name input
              NyTextField.compact(
                controller: controllerName,
                labelText: "Username",
                hintText: "ex: inarum_",
                hintStyle: const TextStyle(
                  fontSize: 16,
                  color: SetColors.textColor,
                ),
                style: const TextStyle(
                  fontSize: 18,
                  color: SetColors.accentColor,
                ),
                validationRules: "not_empty",
                prefixIcon: const Icon(
                  Icons.account_circle_outlined,
                  color: SetColors.accentColor,
                ),
                cursorColor: SetColors.primaryColor,
                backgroundColor: SetColors.primaryColor.withAlpha(25),
              ),
              const SizedBox(height: 15),

              // Email input
              NyTextField.emailAddress(
                controller: controllerEmail,
                labelText: "Email Address",
                hintText: "ex: indriarum@gmail.com",
                hintStyle: const TextStyle(
                  fontSize: 16,
                  color: SetColors.textColor,
                ),
                style: const TextStyle(
                  fontSize: 18,
                  color: SetColors.accentColor,
                ),
                validationRules: "email|min:10",
                prefixIcon: const Icon(
                  Icons.mail_outline_rounded,
                  color: SetColors.accentColor,
                ),
                cursorColor: SetColors.primaryColor,
                backgroundColor: SetColors.primaryColor.withAlpha(25),
              ),
              const SizedBox(height: 15),

              // Password input
              NyTextField.password(
                controller: controllerPassword,
                labelText: "Password",
                hintText: "ex:1In4rum<3",
                hintStyle: const TextStyle(
                  fontSize: 16,
                  color: SetColors.textColor,
                ),
                style: const TextStyle(
                  fontSize: 18,
                  color: SetColors.accentColor,
                ),
                validationRules: "password_v2",
                passwordVisible: true,
                prefixIcon: const Icon(
                  Icons.lock_outline_rounded,
                  color: SetColors.accentColor,
                ),
                cursorColor: SetColors.primaryColor,
                backgroundColor: SetColors.primaryColor.withAlpha(25),
              ),
              const SizedBox(height: 15),

              // Password confirmation input
              NyTextField.password(
                controller: controllerPassword2,
                labelText: "Password Confirmation",
                style: const TextStyle(
                  fontSize: 18,
                  color: SetColors.accentColor,
                ),
                validationRules: "password_v2",
                passwordVisible: true,
                prefixIcon: const Icon(
                  Icons.lock_outline_rounded,
                  color: SetColors.accentColor,
                ),
                cursorColor: SetColors.primaryColor,
                backgroundColor: SetColors.primaryColor.withAlpha(25),
              ),
              const SizedBox(height: 35),

              // Sign up button
              MaterialButton(
                color: SetColors.primaryColor,
                hoverColor: SetColors.accentColor,
                padding:
                    const EdgeInsets.symmetric(vertical: 11, horizontal: 35),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                onPressed: () {
                  String name = controllerName.text;
                  String email = controllerEmail.text;
                  String password = controllerPassword.text;
                  String password2 = controllerPassword.text;
                  validate(
                    rules: {
                      "name": [name, "not_empty"],
                      "email": [email, "email|min:10"],
                      "password": [password, "password_v2"],
                      "password2": [password2, "password_v2"]
                    },
                    onSuccess: () {
                      signUpUser();
                    },
                  );
                },
                child: const Text(
                  "Sign up",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: SetColors.milkyColor,
                  ),
                ),
              ),
              const SizedBox(height: 25),

              // Sign in
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/sign-in");
                  },
                  child: const Text(
                    'Already an account? Sign in',
                    style: TextStyle(
                      color: SetColors.primaryColor,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
