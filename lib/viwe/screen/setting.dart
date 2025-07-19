import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_chat/core/constant/color.dart';
import 'package:scholar_chat/provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:scholar_chat/viwe/screen/about.dart';
import 'package:scholar_chat/viwe/screen/box.dart';
import 'package:scholar_chat/viwe/screen/mybooking.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage();

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDark = false;
  String selectedLanguage = 'en';

  void toggleTheme(bool value) {
    setState(() {
      isDark = value;
    });
  }

  void changeLanguage(String lang) {
    setState(() {
      selectedLanguage = lang;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Consumer<UiProvider>(builder: (context, UiProvider notifier, child) {
        return Stack(
          children: [
         
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColor.primaryColor, AppColor.back],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),

          
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: Container(
                color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.1),
              ),
            ),

            ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                   height: MediaQuery.of(context).size.height * 0.3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      'images/setting.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.back,
                        blurRadius: 10,
                      //  offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                    child: Column(
                      children: [
                        ListTile(
                           leading: Icon(Icons.dark_mode, color: AppColor.back),
                          title: Text("Dark Mode"),
                          trailing: Switch(
                            value: notifier.isDark,
                            onChanged: (value) => notifier.changeTheme(),
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.language_outlined, color: AppColor.back),
                          title: const Text("Change Language"),
                          trailing: Icon(Icons.arrow_forward_ios, color: AppColor.back),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text("Select Language"),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ListTile(
                                        title: const Text("Arabic"),
                                        onTap: () => changeLanguage('ar'),
                                      ),
                                      ListTile(
                                        title: const Text("English"),
                                        onTap: () => changeLanguage('en'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.comment_rounded, color: AppColor.back),
                          title: const Text("Complaints Box"),
                          onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ComplaintPage()),
                    );
                  },
                        ),
                      ListTile(
                        leading: Icon(Icons.event_note_outlined, color: AppColor.back),
                      title: const Text("My Bookings"),
                        onTap: () {
                          Get.to(MyBookingsScreen());
                        },

                      ),

                        ListTile(
                          leading: Icon(Icons.help_outline_rounded, color: AppColor.back),
                          title: const Text("About App"),
                         onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const AboutAppPage()),
                    );
                  },
                        ),
                        ListTile(
                          leading: Icon(Icons.phone_callback_outlined, color: AppColor.back),
                          title: const Text("Contact Us"),
                          onTap: () async {
                            await launchUrl(Uri.parse("tel:0939888746"));
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.exit_to_app, color: AppColor.back),
                          title: const Text("Logout"),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ],
        );
      }),
    );
  }
}
