import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:scholar_chat/contoller/shared_prefs.dart';
import 'package:scholar_chat/core/constant/routs.dart';
import 'package:scholar_chat/viwe/screen/chat.dart';
import 'package:scholar_chat/viwe/screen/chatss.dart';
import 'package:scholar_chat/viwe/screen/home.dart';
import 'package:scholar_chat/viwe/screen/homepage.dart';
import 'dart:convert';


class logincontroller extends GetxController {
  RxBool loading = false.obs;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  bool isshowpassword = true;


  static const String fixedAdminId = "2";

  showPassword() {
    isshowpassword = !isshowpassword;
    update();
  }

  @override
  void onInit() {
    super.onInit();
  }

  loginvalid() {
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      loginn(email: email.text, password: password.text);
    } else {
      Get.snackbar("خطأ", "الرجاء التحقق من البيانات المدخلة");
    }
  }

  loginn({required String email, required String password}) async {
    print("بدأت عملية تسجيل الدخول");
    loading.value = true;

    try {
      print("البريد الإلكتروني: $email");
      print("كلمة المرور: $password");

      Map<String, dynamic>? responseData =
          await logincontroller.login(email: email, password: password);

      loading.value = false;

      if (responseData != null) {
        print(" تسجيل الدخول ناجح");

        String token = responseData['token'];
        Map<String, dynamic> userData = responseData['userData'];
        String role = userData['role'];
        String userId = userData['id'].toString();

        MyInfoPrefs.saveInfo(name: "token", value: token);
        MyInfoPrefs.saveInfo(name: "role", value: role);
        MyInfoPrefs.saveInfo(name: "userId", value: userId);

        if (role == "admin") {
          Get.offAll(() => EmployeeChatsScreen(employeeId: userId));
        } else if (role == "user") {
          Get.offAll(() => HomeScreen());
        } else {
          Get.snackbar("Error", "Unknown user role",
              backgroundColor: Colors.red, colorText: Colors.white);
        }
      } else {
        print(" فشل تسجيل الدخول - بيانات خاطئة");
        Get.snackbar("Login Failed", "Invalid email or password",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      loading.value = false;
      print(" حصل خطأ أثناء تسجيل الدخول: $e");
      Get.snackbar("Error", "Something went wrong",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  static Future<Map<String, dynamic>?> login(
      {required String email, required String password}) async {
    print("جاري إرسال الطلب إلى الخادم...");
    var headers = {'Accept': 'application/json'};

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://127.0.0.1:8000/api/login'),
    );

    request.fields.addAll({
      'email': email,
      'password': password,
    });

    request.headers.addAll(headers);

    try {
      print("الطلب تم تجهيزه، جاري الإرسال...");
      http.StreamedResponse response = await request.send();
      print("تم استلام الرد من السيرفر، كود الحالة: ${response.statusCode}");

      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        var jsonData = jsonDecode(responseBody);
        print("الرد من السيرفر: $jsonData");

        String? token = jsonData['token'] ?? jsonData['access_token'];
        var userData = jsonData['User'] ?? jsonData['user'];

        if (token != null && userData != null) {
          return {
            'token': token,
            'userData': userData,
          };
        } else {
          print(" الرد لا يحتوي على البيانات المطلوبة.");
          return null;
        }
      } else {
        String errorBody = await response.stream.bytesToString();
        print(" فشل تسجيل الدخول، كود: ${response.statusCode}");
        print("نص الخطأ: $errorBody");
        return null;
      }
    } catch (e) {
      print(" حصل استثناء أثناء إرسال الطلب: $e");
      return null;
    }
  }
}
