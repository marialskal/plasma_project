import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:scholar_chat/contoller/verifycodesignupcontroller.dart';
import 'package:scholar_chat/core/constant/color.dart';
import 'package:scholar_chat/viwe/screen/auth/successSignUp.dart';


import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:scholar_chat/core/constant/color.dart';

class VerifyCodeSignUp extends StatelessWidget {
  const VerifyCodeSignUp();

  @override
  Widget build(BuildContext context) {
   
    final VerifyCodeSignUpControllerImp controller =
        Get.put(VerifyCodeSignUpControllerImp());

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
              const SizedBox(height: 40),
              const Text(
                "Verify Code",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColor.black,
                ),
              ),
              const SizedBox(height: 20),
              Image.asset(
                "images/email.png",
                width: 180,
                height: 180,
              ),
              const SizedBox(height: 25),
              const Text(
                "Enter the verification code",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColor.black,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Please enter the code sent to your email",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: AppColor.black,
                ),
              ),
              const SizedBox(height: 30),
              OtpTextField(
                fieldWidth: 50,
                borderRadius: BorderRadius.circular(10),
                numberOfFields: 6,
                borderColor: AppColor.black,
                showFieldAsBox: true,
                onCodeChanged: (String code) {},
                onSubmit: (String verificationCode) {
                  
                  controller.goToSuccessSignUp(verificationCode);
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
