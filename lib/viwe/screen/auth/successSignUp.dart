import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_chat/core/constant/color.dart';
import 'package:scholar_chat/viwe/screen/auth/loginScreen.dart';
import 'package:scholar_chat/viwe/widget/CustomButtomLogin.dart';

class SuccessSignUp extends StatelessWidget {
  const SuccessSignUp();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
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
              const Text(
                "Registration Successful!",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColor.black,
                ),
              ),
              const SizedBox(height: 30),
              Image.asset(
                "images/success.png",
                width: 200,
                height: 200,
              ),
              const SizedBox(height: 30),
              const Text(
                "Your account has been created successfully.\nYou can now continue to the next step.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: AppColor.black,
                ),
              ),
              const SizedBox(height: 50),
              SizedBox(
                width: double.infinity,
                child: CustomButtomLogin(
                  textbuttom: "Next",
                  onPressed: () {
                  
                     Get.to(() => LoginScreen());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
