import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_chat/contoller/forget_password_controller.dart';
import 'package:scholar_chat/viwe/widget/CustomButtomLogin.dart';
import 'package:scholar_chat/viwe/widget/customtext.dart';
import 'package:scholar_chat/core/constant/color.dart';

class ForgetPassword extends StatelessWidget {
  final controller = Get.put(ForgetPasswordController());

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Forgot Password?", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColor.black)),
              const SizedBox(height: 30),
              Image.asset("images/email.png", width: 200, height: 200),
              const SizedBox(height: 30),
              const Text("Please enter your email address", textAlign: TextAlign.center, style: TextStyle(fontSize: 18, color: AppColor.black)),
              const SizedBox(height: 30),
              CustomText(
                myController: controller.emailController,
                iconData: Icons.email,
                valid: (val) => null,
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: CustomButtomLogin(
                  textbuttom: "Send",
                  onPressed: controller.sendEmail,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
