import 'package:dandaily/app/controllers/controller.dart';
import 'package:flutter/material.dart';

class LupaPasswordController extends Controller {
  String? emailError;
  bool isButtonActive = false;

  final TextEditingController emailController = TextEditingController();
  final FocusNode focusNode = FocusNode(); // FocusNode untuk memantau kursor

  LupaPasswordController() {
    focusNode.addListener(updateButtonState);
    emailController.addListener(updateButtonState);
  }

  void validateEmail() {
    String email = emailController.text.trim();
    if (email.isEmpty) {
      emailError = 'Email tidak boleh kosong';
    } else if (!RegExp(r'^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z0-9]+$')
        .hasMatch(email)) {
      emailError = 'Email harus yang benar';
    } else {
      emailError = null;
    }
  }

  void updateButtonState() {
    isButtonActive =
        focusNode.hasFocus && emailController.text.trim().isNotEmpty;
  }
}
