import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_chat/core/services/services.dart';
import 'package:scholar_chat/viwe/screen/favorite.dart';
import 'package:scholar_chat/viwe/screen/homepage.dart';
import 'package:scholar_chat/viwe/screen/profile.dart';
import 'package:scholar_chat/viwe/screen/setting.dart';

abstract class HomeScreenController extends GetxController {
  void changePage(int currentPage);
}

class HomeScreenControllerImp extends HomeScreenController {

  MyServices myServices = Get.find();

  int currentpage = 0;

  List<Widget> listPage = [
    Homepage(),
    SettingsPage(),
   ProfilePage(),
    FavoritePage(),
  ];

  @override
  void changePage(int i) {
    currentpage = i;
    update();  
  }
}
