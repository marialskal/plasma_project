
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_chat/core/constant/color.dart';
import 'package:scholar_chat/contoller/signup_controller.dart';
import 'package:scholar_chat/core/function/validInput.dart';
import 'package:scholar_chat/viwe/screen/auth/loginScreen.dart';
import 'package:scholar_chat/viwe/widget/CustomButtomLogin.dart';
import 'package:scholar_chat/viwe/widget/customtext.dart';

class SignUpScreen extends StatelessWidget {
  final SignUpController controller = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Obx(() {
        return controller.loading.value
            ? const Center(child: CircularProgressIndicator())
            : Center(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColor.primaryColor, AppColor.back],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Form(
                    key: controller.formstate,
                    child: ListView(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                      children: [
                        ColorFiltered(
                          colorFilter: const ColorFilter.mode(
                            Color(0xFFD8A165),
                            BlendMode.srcIn,
                          ),
                          child: Image.asset(
                            'images/logo1.png',
                            width: 120,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(screenWidth * 0.05),
                          decoration: BoxDecoration(
                            color: AppColor.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Name",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.back)),
                              ),
                              SizedBox(height: screenHeight * 0.01),
                              CustomText(
                                myController: controller.name,
                                iconData: Icons.person,
                                obscureText: false,
                                valid: (val) {
                                  return validInput(val!, 5, 100, "Name");
                                },
                              ),
                              SizedBox(height: screenHeight * 0.02),
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Email",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.back)),
                              ),
                              SizedBox(height: screenHeight * 0.01),
                              CustomText(
                                myController: controller.email,
                                iconData: Icons.email,
                                obscureText: false,
                                valid: (val) {
return validInput(val!, 10, 100, "Email");
                                },
                              ),
                              SizedBox(height: screenHeight * 0.02),
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Password",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.back)),
                              ),
                              SizedBox(height: screenHeight * 0.01),
                              CustomText(
                                myController: controller.password,
                                iconData: Icons.lock,
                                obscureText: true,
                                valid: (val) {
                                  return validInput(val!, 5, 100, "Password");
                                },
                              ),
                              SizedBox(height: screenHeight * 0.02),
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Confirm Password",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.back)),
                              ),
                              SizedBox(height: screenHeight * 0.01),
                              CustomText(
                                myController: controller.password_confirmation,
                                iconData: Icons.lock_outline,
                                obscureText: true,
                                valid: (val) {
                                  return validInput(val!, 5, 100, "Password");
                                },
                              ),
                              SizedBox(height: screenHeight * 0.03),
                              Center(
                                child: CustomButtomLogin(
                                  textbuttom: "Sign up",
                                  onPressed: () {
                                    controller.siginvalid();
                                  },
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.02),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("Do you have an account?",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: AppColor.back)),
                                  SizedBox(width: screenWidth * 0.05),
                                  CustomButtomLogin(
                                    textbuttom: "Log in",
                                    onPressed: () {
                                      Get.to(() => LoginScreen());
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
      }),
    );
  }
}