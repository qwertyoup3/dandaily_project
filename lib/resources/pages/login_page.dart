import 'package:dandaily/config/assets_image.dart';
import 'package:dandaily/config/colors_config.dart';
import 'package:dandaily/resources/pages/home_page.dart';
import 'package:dandaily/resources/pages/lupa_password_page.dart';
import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';
import '/app/controllers/login_controller.dart';

class LoginPage extends NyStatefulWidget<LoginController> {
  static const path = '/login';

  LoginPage({super.key}) : super(child: () => _LoginPageState());
}

class _LoginPageState extends NyState<LoginPage> {
  /// [LoginController] controller
  LoginController get controller => widget.controller;

  @override
  void initState() {
    super.initState();
    // Listener untuk memperbarui UI ketika status tombol berubah
    controller.usernameController.addListener(() {
      setState(() {});
    });
    controller.passwordController.addListener(() {
      setState(() {});
    });
    controller.focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.usernameController.dispose();
    controller.passwordController.dispose();
    controller.focusNode.dispose();
    super.dispose();
  }

  void onSubmit() {
    setState(() {
      controller.validateUsername();
      controller.validatePassword();
    });

    if (controller.usernameError == null && controller.passwordError == null) {
      Navigator.pushNamed(context, HomePage.path);
    }
  }

  @override
  Widget build(BuildContext context) {
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
            SizedBox(
              width: 255,
              height: 255,
              child: Image.asset(AssetImages.dandailyGreenLogo),
            ),
            const SizedBox(height: 10),

            // Title
            const Text(
              "Let's Get Started!",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: SetColors.primaryColor,
              ),
            ),
            const SizedBox(height: 30),

            // Username Input
            TextField(
              controller: controller.usernameController,
              focusNode: controller.focusNode,
              decoration: InputDecoration(
                hintText: 'Username',
                hintStyle: const TextStyle(
                  color: SetColors.textColor,
                ),
                errorText: controller.usernameError,
                filled: true,
                fillColor: SetColors.secondaryColor,
                errorStyle:
                    const TextStyle(color: SetColors.accentColor, fontSize: 12),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: SetColors.textColor,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: SetColors.primaryColor,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: SetColors.errorColor,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: SetColors.errorColor,
                  ),
                ),
                contentPadding: const EdgeInsets.all(16),
              ),
            ),
            const SizedBox(height: 16),

            // Password Input
            TextField(
              controller: controller.passwordController,
              obscureText: !controller.isPasswordVisible,
              decoration: InputDecoration(
                hintText: 'Password',
                hintStyle: const TextStyle(
                  color: SetColors.textColor,
                ),
                errorText: controller.passwordError,
                filled: true,
                fillColor: SetColors.secondaryColor,
                errorStyle:
                    const TextStyle(color: SetColors.accentColor, fontSize: 12),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: SetColors.textColor,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: SetColors.primaryColor,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: SetColors.errorColor,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: SetColors.errorColor,
                  ),
                ),
                contentPadding: const EdgeInsets.all(16),
                suffixIcon: IconButton(
                  icon: Icon(
                    controller.isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: controller.passwordError != null
                        ? SetColors.errorColor
                        : SetColors.textColor,
                  ),
                  onPressed: () {
                    controller.togglePasswordVisibility();
                    setState(() {});
                  },
                ),
              ),
            ),

            // Lupa Password
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, LupaPasswordPage.path);
                },
                child: const Text(
                  'Lupa password Anda?',
                  style: TextStyle(
                    color: SetColors.primaryColor,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Login Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: controller.isButtonActive
                      ? SetColors.primaryColor
                      : SetColors.textColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Kirim',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: SetColors.secondaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
