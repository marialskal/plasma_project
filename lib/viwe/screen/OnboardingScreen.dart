import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_chat/contoller/onboarding_controller.dart';
import 'package:scholar_chat/core/constant/color.dart';
import 'package:scholar_chat/core/constant/static.dart';

class OnboardingScreen extends GetView<OnBoardingControllerImp> {
  const OnboardingScreen();

  @override
  Widget build(BuildContext context) {
    Get.put(OnBoardingControllerImp());
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: PageView.builder(
        controller: controller.pageController,
        onPageChanged: (val) => controller.onPageChanged(val),
        itemCount: onBoardingList.length,
        itemBuilder: (context, i) => Stack(
          children: [
            SizedBox(
              width: width,
              height: height,
              child: Image.asset(
                onBoardingList[i].image!,
                fit: BoxFit.cover,
              ),
            ),
            Opacity(
              opacity: 0.6,
              child: Padding(
                padding: EdgeInsets.only(
                  top: height / 1.5,
                  left: width / 6.6,
                  right: width / 8,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.transparent,
                  ),
                  width: width / 1,
                  height: height / 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GetBuilder<OnBoardingControllerImp>(
                        builder: (controller) => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            onBoardingList.length,
                            (index) => AnimatedContainer(
                              margin: const EdgeInsets.only(right: 9),
                              duration: const Duration(milliseconds: 900),
                              height: 4,
                              width: controller.currentPage == index ? 30 : 9,
                              decoration: BoxDecoration(
                                color: AppColor.primaryColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Text(
                        onBoardingList[i].title!.tr,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 20.0),
                      Text(
                        onBoardingList[i].body!.tr,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 20.0),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.back,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: IconButton(
                          onPressed: () {
                            controller.next();
                          },
                          icon: const Icon(
                            Icons.arrow_forward,
                            color: AppColor.primaryColor,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
