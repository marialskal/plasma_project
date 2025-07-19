import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:scholar_chat/contoller/forget_password_controller.dart';
import 'package:scholar_chat/core/constant/color.dart';

class VerifyCodeResetPassword extends StatelessWidget {
  const VerifyCodeResetPassword();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ForgetPasswordController>();

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColor.primaryColor, AppColor.back],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Verify Code", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColor.black)),
              const SizedBox(height: 20),
              Image.asset("images/email.png", width: 180, height: 180),
              const SizedBox(height: 25),
              const Text("Enter the verification code", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColor.black)),
              const SizedBox(height: 10),
              const Text("Please enter the code sent to your email", textAlign: TextAlign.center, style: TextStyle(fontSize: 16, color: AppColor.black)),
              const SizedBox(height: 30),
              OtpTextField(
                fieldWidth: 50,
                borderRadius: BorderRadius.circular(10),
                numberOfFields: 6,
                borderColor: AppColor.black,
                showFieldAsBox: true,
                onSubmit: (String code) => controller.verifyCode(code),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
