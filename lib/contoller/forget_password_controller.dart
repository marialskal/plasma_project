import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:scholar_chat/viwe/screen/auth/forgetpassword/successresetpassword.dart';
import 'dart:convert';

import '../../../viwe/screen/auth/forgetpassword/resetpassword.dart';
import '../../../viwe/screen/auth/forgetpassword/verifycoderesetpassword.dart';

class ForgetPasswordController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController rePassword = TextEditingController();

  String email = '';

  Future<void> sendEmail() async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/api/send-reset-code'),
      body: {'email': emailController.text},
    );

    if (response.statusCode == 200) {
      email = emailController.text;
      Get.to(() => const VerifyCodeResetPassword());
    } else {
      Get.snackbar("Error", "Email not found or server error");
    }
  }

  Future<void> verifyCode(String code) async {
    codeController.text = code;
    Get.to(() => ResetPassword());
  }

Future<void> resetPassword() async {
  if (newPassword.text != rePassword.text) {
    Get.snackbar("Error", "Passwords do not match");
    return;
  }

  final response = await http.post(
    Uri.parse('http://127.0.0.1:8000/api/reset-password'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'email': email,
      'code': codeController.text,
      'password': newPassword.text,
      'password_confirmation': rePassword.text, 
    }),
  );

  if (response.statusCode == 200) {
    Get.to(() => const SuccuessResetPassowrd());

  } else {
    Get.snackbar("Error", "Invalid code or server error");
  }
}

}
