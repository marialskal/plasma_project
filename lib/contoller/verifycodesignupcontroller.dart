import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:scholar_chat/core/class/StatusRequest.dart';
import 'package:scholar_chat/viwe/screen/auth/successSignUp.dart';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:scholar_chat/viwe/screen/auth/successSignUp.dart';

abstract class VerifyCodeSignUpController extends GetxController {
  checkcode();
  goToSuccessSignUp(String verifycode);
}

class VerifyCodeSignUpControllerImp extends VerifyCodeSignUpController {
  late String email;

  @override
  void onInit() {
    email = Get.arguments['email']; 
    super.onInit();
  }

  @override
  checkcode() {}

  @override
  goToSuccessSignUp(String verifycode) async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    var url = Uri.parse('http://127.0.0.1:8000/api/send-reset-code'); 

    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode({
        'email': email,
        'code': verifycode,
      }),
    );

    if (response.statusCode == 200) {
      Get.snackbar("تم التحقق", "يرجى تسجيل الدخول الآن",
          backgroundColor: Colors.green, colorText: Colors.white);
      Get.to(() => const SuccessSignUp());
    } else {
      Get.defaultDialog(
        title: "تحذير",
        middleText: "رمز التحقق غير صحيح",
      );
    }
  }
}
