import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:scholar_chat/contoller/shared_prefs.dart';
import 'package:scholar_chat/viwe/screen/auth/verifyCodeSignUp.dart';
import 'package:scholar_chat/viwe/screen/homepage.dart';

class SignUpController extends GetxController {
  RxBool loading = false.obs;

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController password_confirmation = TextEditingController();

  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
  }

  siginvalid() {
    print("🔍 التحقق من صحة البيانات المدخلة");
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      print(" النموذج صالح");
      if (password.text != password_confirmation.text) {
        print("كلمة المرور وتأكيدها غير متطابقين");
        Get.snackbar("خطأ", "كلمة المرور وتأكيدها غير متطابقين",
            backgroundColor: Colors.red, colorText: Colors.white);
        return;
      }
      print(" بدء عملية التسجيل");
      siginn(
        name: name.text,
        email: email.text,
        password: password.text,
        password_confirmation: password_confirmation.text,
      );
    } else {
      print(" النموذج غير صالح");
      Get.snackbar("خطأ", "الرجاء التحقق من البيانات المدخلة");
    }
  }

  siginn({
    required String name,
    required String email,
    required String password,
    required String password_confirmation,
  }) async {
    loading.value = true;

    print(" إرسال الطلب إلى الدالة الثابتة للتسجيل");
    bool response = await SignUpController.sigin(
      name: name,
      email: email,
      password: password,
      password_confirmation: password_confirmation,
    );

    loading.value = false;

    if (response == true) {
      print(" تم التسجيل بنجاح");
{
  Get.offAll(() => const VerifyCodeSignUp(), arguments: {
    'email': email, 
  });
}

    } else {
      print(" فشل التسجيل");
      Get.snackbar("فشل التسجيل", "تأكد من صحة البيانات أو أن البريد مستخدم",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  static Future<bool> sigin({
    required String name,
    required String email,
    required String password,
    required String password_confirmation,
  }) async {
    print(" بدء تجهيز الطلب");
    var headers = {'Accept': 'application/json'};

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://127.0.0.1:8000/api/register'),
    );

    request.fields.addAll({
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': password_confirmation,
    });

    request.headers.addAll(headers);

    print(" البيانات المرسلة: ${request.fields}");

    http.StreamedResponse response = await request.send();

    print(" تم استلام الرد من السيرفر - الحالة: ${response.statusCode}");

    if (response.statusCode == 200 || response.statusCode == 201) {
 
      String responseBody = await response.stream.bytesToString();
      print(" جسم الرد: $responseBody");

      var jsonData = jsonDecode(responseBody);

      print(" حفظ التوكن: ${jsonData['token']}");

if (jsonData.containsKey('token') && jsonData['token'] != null) {
  print(" حفظ التوكن: ${jsonData['token']}");
  MyInfoPrefs.saveInfo(name: "token", value: jsonData['token']);
} else {
  print(" لم يتم العثور على التوكن في الرد: $jsonData");
}

      print(" التسجيل ناجح");
      return true;
    } else {
      print(" فشل الاستجابة: ${response.statusCode} - ${response.reasonPhrase}");
      return false;
    }
  }
}