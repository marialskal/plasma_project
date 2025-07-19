import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:scholar_chat/core/constant/color.dart';
import 'package:scholar_chat/model/UserModel.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);


  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool loading = true;
  User? user;

  @override
  void initState() {
    super.initState();
    getInfo();
  }

  getInfo() async {
    setState(() {
      loading = true;
    });

    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer 14|a0rA2BjbfeFUHY8BAxU7rP7kGuhylS60uNw0A9lQb16e6c15'
    };

    var request = http.Request('GET', Uri.parse('http://127.0.0.1:8000/api/profile'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      var jsonData = json.decode(data);

      setState(() {
        user = User.fromJson(jsonData['user']);
        loading = false;
      });
    } else {
      print(response.reasonPhrase);
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : user == null
              ? const Center(child: Text("لا توجد بيانات لعرضها"))
              : Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColor.primaryColor, AppColor.back],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                    child: Container(
                      color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.1),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 4,
                            child:  Expanded(
                    flex: 4,
                    child: Container(
                      child: Image.asset(
                        'images/pro.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                          ),
                          Expanded(
                            flex: 6,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColor.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColor.back,
                                      blurRadius: 10,
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: ListView(
                                    children: [
                                      const SizedBox(height: 20),
                                      ProfileField(title: "الاسم", value: user!.name),
                                      const SizedBox(height: 20),
                                      ProfileField(title: "البريد الإلكتروني", value: user!.email),
                                      const SizedBox(height: 20),
                                      ProfileField(
                                          title: "العنوان",
                                          value: user!.address.isNotEmpty ? user!.address : "-"),
                                      const SizedBox(height: 20),
                                      ProfileField(title: "النقاط", value: user!.points.toString()),
                                    ],
                                  ),
                                ),
                              ),
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

class ProfileField extends StatelessWidget {
  final String title;
  final String value;

 const ProfileField({
  Key? key,
  required this.title,
  required this.value,
}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          textAlign: TextAlign.right,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          decoration: BoxDecoration(
            color: AppColor.primaryColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColor.back, width: 1.5),
          ),
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: AppColor.black,
            ),
          ),
        ),
      ],
    );
  }
}

