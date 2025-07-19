import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_chat/contoller/forget_password_controller.dart';
import 'package:scholar_chat/viwe/widget/CustomButtomLogin.dart';
import 'package:scholar_chat/viwe/widget/customtext.dart';
import 'package:scholar_chat/core/constant/color.dart';

class ResetPassword extends StatelessWidget {
  final controller = Get.find<ForgetPasswordController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColor.primaryColor, AppColor.back],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Reset Password", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColor.black)),
                const SizedBox(height: 30),
                Image.asset("images/password.png", width: 200, height: 200),
                const SizedBox(height: 30),
                const Text("Enter your new password below.", textAlign: TextAlign.center, style: TextStyle(fontSize: 18, color: AppColor.black)),
                const SizedBox(height: 30),
                CustomText(
                  myController: controller.newPassword,
                  iconData: Icons.lock,
                  obscureText: true,
                  valid: (val) => null,
                ),
                const SizedBox(height: 20),
                CustomText(
                  myController: controller.rePassword,
                  iconData: Icons.lock_outline,
                  obscureText: true,
                  valid: (val) => null,
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  child: CustomButtomLogin(
                    textbuttom: "Confirm",
                    onPressed: controller.resetPassword,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
