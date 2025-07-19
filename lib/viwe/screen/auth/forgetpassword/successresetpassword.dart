import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_chat/viwe/screen/auth/loginScreen.dart';
import 'package:scholar_chat/viwe/widget/CustomButtomLogin.dart';
import 'package:scholar_chat/core/constant/color.dart';

class SuccuessResetPassowrd extends StatelessWidget {
  const SuccuessResetPassowrd();

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
              const Text("Password Reset Successful!", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColor.black)),
              const SizedBox(height: 30),
              Image.asset("images/success.png", width: 200, height: 200),
              const SizedBox(height: 30),
              const Text("You can now log in with your new password.", textAlign: TextAlign.center, style: TextStyle(fontSize: 18, color: AppColor.black)),
              const SizedBox(height: 50),
              SizedBox(
                width: double.infinity,
                child: CustomButtomLogin(
                  textbuttom: "Go to Login",
                  onPressed: () => Get.offAll(() => LoginScreen()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
