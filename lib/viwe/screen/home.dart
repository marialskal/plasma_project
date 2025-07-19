import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_chat/contoller/home_controller.dart';
import 'package:scholar_chat/core/constant/color.dart';
import 'package:scholar_chat/viwe/screen/product.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final HomeScreenControllerImp controller = Get.put(HomeScreenControllerImp());

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColor.back,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.back,
        onPressed: () {
          Get.to(() => ProductsPage());
        },
        child: const Icon(
          Icons.shopping_bag_outlined,
          color: Color.fromARGB(255, 243, 42, 42),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: SizedBox(
        height: screenHeight * 0.10,
        child: BottomAppBar(
          notchMargin: 10,
          child: Padding(
            padding: const EdgeInsets.only(right: 5, left: 5),
            child: Row(
              children: [
                Expanded(
                  child: CustomButtonAppBar(
                    textbutton: "Home",
                    icondata: Icons.home,
                    onPressed: () => controller.changePage(0),
                    active: controller.currentpage == 0,
                    screenHeight: screenHeight,
                  ),
                ),
                Expanded(
                  child: CustomButtonAppBar(
                    textbutton: "Settings",
                    icondata: Icons.settings,
                    onPressed: () => controller.changePage(1),
                    active: controller.currentpage == 1,
                    screenHeight: screenHeight,
                  ),
                ),
                const Spacer(), // للفاصل بين الجهتين
                Expanded(
                  child: CustomButtonAppBar(
                    textbutton: "Profile",
                    icondata: Icons.person,
                    onPressed: () => controller.changePage(2),
                    active: controller.currentpage == 2,
                    screenHeight: screenHeight,
                  ),
                ),
                Expanded(
                  child: CustomButtonAppBar(
                    textbutton: "Favorites",
                    icondata: Icons.favorite,
                    onPressed: () => controller.changePage(3),
                    active: controller.currentpage == 3,
                    screenHeight: screenHeight,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: GetBuilder<HomeScreenControllerImp>(
        builder: (_) {
          return controller.listPage[controller.currentpage];
        },
      ),
    );
  }
}

class CustomButtonAppBar extends StatelessWidget {
  final String textbutton;
  final IconData icondata;
  final VoidCallback onPressed;
  final bool active;
  final double screenHeight;

  const CustomButtonAppBar({
    Key? key,
    required this.textbutton,
    required this.icondata,
    required this.onPressed,
    required this.active,
    required this.screenHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = active ? AppColor.back : Colors.grey;

    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icondata,
            color: color,
            size: screenHeight * 0.03,
          ),
          SizedBox(height: screenHeight * 0.005),
          Text(
            textbutton,
            style: TextStyle(
              color: color,
              fontSize: screenHeight * 0.014,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
