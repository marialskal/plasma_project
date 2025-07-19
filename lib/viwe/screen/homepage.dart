import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_chat/contoller/dep_controller.dart';
import 'package:scholar_chat/contoller/offer_controller.dart';
import 'package:scholar_chat/contoller/shared_prefs.dart';
import 'package:scholar_chat/core/constant/color.dart';
import 'package:scholar_chat/viwe/screen/category.dart';
import 'package:scholar_chat/viwe/screen/chat.dart';
import 'package:scholar_chat/viwe/screen/offerDetailsPage.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final CategoryController categoryController = Get.put(CategoryController());
  final OfferController offerController = Get.put(OfferController());

  // رابط السيرفر الأساسي
  static const String baseUrl = "http://127.0.0.1:8000";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: AppColor.white),
            onPressed: () {
              // Get.to(() => NotificationsPage());
            },
          ),
          IconButton(
            icon: const Icon(Icons.chat_bubble_outline, color: AppColor.white),
            onPressed: () async {
              String? userId = await MyInfoPrefs.getInfo(name: "userId");

              if (userId == null) {
                Get.snackbar("خطأ", "يجب تسجيل الدخول أولاً",
                    backgroundColor: Colors.red, colorText: Colors.white);
                return;
              }
              const String fixedAdminId = "2";
              Get.to(() => ChatScreen(
                    customerId: userId,
                    employeeId: fixedAdminId,
                  ));
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // خلفية متدرجة
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColor.primaryColor, AppColor.back],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // تأثير الضباب
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Container(
              color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.1),
            ),
          ),

          // المحتوى الرئيسي
          ListView(
            padding: const EdgeInsets.fromLTRB(15, 50, 15, 0),
            children: [
              // البانر العلوي
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.back,
                      blurRadius: 10,
                    ),
                  ],
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        "images/booking.png",
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 20),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Book your appointment now",
                            style: TextStyle(
                              fontSize: 26,
                              color: AppColor.back,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Enjoy the best beauty services we have.",
                            style: TextStyle(
                              fontSize: 18,
                              color: AppColor.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // عنوان الأقسام
              const Text(
                "Clinic Sections",
                style: TextStyle(
                  fontSize: 22,
                  color: AppColor.black,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 15),

              // عرض الأقسام بشكل أفقي
              SizedBox(
                height: 100,
                child: Obx(() {
                  if (categoryController.loading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categoryController.categories.length,
                    itemBuilder: (context, index) {
                      var category = categoryController.categories[index];
                      return GestureDetector(
                        onTap: () {
                          Get.to(() => CategoryServicesPage(
                                categoryId: category.id,
                                categoryName: category.name,
                              ));
                        },
                        child: Container(
                          width: 80,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  color: AppColor.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColor.back,
                                      blurRadius: 10,
                                    ),
                                  ],
                                ),
                                padding: const EdgeInsets.all(15),
                                child: category.iconUrl != null
                                    ? ClipOval(
                                        child: Image.network(
                                          "$baseUrl${category.iconUrl}",
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error,
                                                  stackTrace) =>
                                              const Icon(Icons.face,
                                                  size: 30),
                                        ),
                                      )
                                    : const Icon(Icons.category, size: 30),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                category.name,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: AppColor.black,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),

              const SizedBox(height: 30),

              // عنوان العروض
              const Text(
                "Our Offers",
                style: TextStyle(
                  fontSize: 22,
                  color: AppColor.black,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 15),

              // عرض العروض كـ Grid
              Obx(() {
                if (offerController.loading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 2 / 2,
                  ),
                  itemCount: offerController.offers.length,
                  itemBuilder: (context, index) {
                    var offer = offerController.offers[index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => OfferDetailsPage(offerId: offer.id));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              color: AppColor.back,
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ClipRRect(
  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
  child: Container(
    height: 150, 
    width: double.infinity, 
    child: Image.network(
      "http://127.0.0.1:8000/uploads/${offer.image}",
      fit: BoxFit.fitWidth,
      errorBuilder: (_, __, ___) => Image.asset("images/mm.jpg"),
    ),
  ),
),


                            Container(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10),
                              alignment: Alignment.center,
                              child: Text(
                                offer.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}
