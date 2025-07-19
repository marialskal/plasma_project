import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:scholar_chat/viwe/screen/OnboardingScreen.dart';

import '../../core/constant/color.dart';



class LanguageSelectionPage extends StatelessWidget {
  Future<void> _saveLanguage(String langCode, String countryCode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', langCode);
    await prefs.setString('country_code', countryCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.back,
        title: Text('choose_lang'.tr, style: const TextStyle(color: AppColor.white)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColor.white),
      ),
      body: Stack(
        children: [
    
          Container(
            decoration: const BoxDecoration(
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
              color: Colors.white.withOpacity(0.1),
            ),
          ),

    
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
          
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: Image.asset(
                    'images/language.png', 
                    height: 150,
                  ),
                ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.back,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () async {
                    await _saveLanguage('ar', 'AR');
                    Get.updateLocale(const Locale('ar', 'AR'));
                    Get.off(() => OnboardingScreen());
                  },
                  child: Text('arabic'.tr, style: const TextStyle(fontSize: 18)),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.back,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () async {
                    await _saveLanguage('en', 'US');
                    Get.updateLocale(const Locale('en', 'US'));
                    Get.off(() => OnboardingScreen());
                  },
                  child: Text('english'.tr, style: const TextStyle(fontSize: 18)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
