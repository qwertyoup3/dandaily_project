import 'package:flutter/material.dart';

import '/app/controllers/controller.dart';

class LoginController extends Controller {
  String? usernameError;
  String? passwordError;
  bool isPasswordVisible = false;
  bool isButtonActive = false;

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode focusNode = FocusNode(); // FocusNode untuk memantau kursor

  LoginController() {
    focusNode.addListener(updateButtonState);
    usernameController.addListener(updateButtonState);
    passwordController.addListener(updateButtonState);
  }

  void validateUsername() {
    String username = usernameController.text.trim();
    if (username.isEmpty) {
      usernameError = 'Username tidak boleh kosong';
    } else if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(username)) {
      usernameError = 'Username harus yang benar';
    } else {
      usernameError = null;
    }
  }

  void validatePassword() {
    String password = passwordController.text.trim();
    if (password.isEmpty) {
      passwordError = 'Password tidak boleh kosong';
    } else if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(password)) {
      passwordError = 'Password harus yang benar';
    } else {
      passwordError = null;
    }
  }

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
  }

  void updateButtonState() {
    isButtonActive = focusNode.hasFocus &&
        usernameController.text.trim().isNotEmpty &&
        passwordController.text.trim().isNotEmpty;
  }
}
