import 'package:dandaily/service/auth_service.dart';
import 'package:dandaily/config/assets_image.dart';
import 'package:dandaily/config/colors_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';

class SignInPage extends NyStatefulWidget {
  static RouteView path = ("/sign-in", (context) => SignInPage());

  SignInPage({super.key}) : super(child: () => _SignInPageState());
}

class _SignInPageState extends NyPage<SignInPage> {
  @override
  get init => () {
        FirebaseAuth.instance.setSettings(
          appVerificationDisabledForTesting: false,
        );
      };

  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  User? user;
  bool _isLoading = false;

  Future<void> signInUser() async {
    if (controllerEmail.text.isEmpty || controllerPassword.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      user = await FirebaseAuthService().signIn(
        email: controllerEmail.text.trim(),
        password: controllerPassword.text.trim(),
      );

      if (user != null && mounted) {
        Navigator.pushNamed(context, "/dashboard");
      }
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'invalid-credential':
          message = 'Invalid email or password.';
          break;
        case 'user-disabled':
          message = 'This account has been disabled.';
          break;
        case 'user-not-found':
          message = 'No account found with this email.';
          break;
        case 'wrong-password':
          message = 'Incorrect password.';
          break;
        default:
          message = 'An error occurred. Please try again.';
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('An unexpected error occurred')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
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
                'Welcome back!',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: SetColors.primaryColor,
                ),
              ),
              const SizedBox(height: 55),

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
                borderRadius: BorderRadius.circular(25),
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
                hintText: "ex: 1In4rum<3",
                hintStyle: const TextStyle(
                  fontSize: 16,
                  color: SetColors.textColor,
                ),
                style: const TextStyle(
                  fontSize: 18,
                  color: SetColors.accentColor,
                ),
                validationRules: "password_v2",
                borderRadius: BorderRadius.circular(25),
                passwordVisible: true,
                prefixIcon: const Icon(Icons.lock_outline_rounded,
                    color: SetColors.accentColor),
                cursorColor: SetColors.primaryColor,
                backgroundColor: SetColors.primaryColor.withAlpha(25),
              ),
              const SizedBox(height: 35),

              // Sign in button
              MaterialButton(
                color: SetColors.primaryColor,
                hoverColor: SetColors.accentColor,
                padding:
                    const EdgeInsets.symmetric(vertical: 11, horizontal: 35),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                onPressed: _isLoading
                    ? null
                    : () {
                        String email = controllerEmail.text;
                        String password = controllerPassword.text;
                        validate(
                          rules: {
                            "email": [email, "email|min:10"],
                            "password": [password, "password_v2"],
                          },
                          onSuccess: () {
                            signInUser();
                          },
                        );
                      },
                child: _isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: SetColors.milkyColor,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
                        "Sign in",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: SetColors.milkyColor,
                        ),
                      ),
              ),
              const SizedBox(height: 25),

              // Sign up
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/sign-up");
                  },
                  child: const Text(
                    'Don’t have an account? Get started!',
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
