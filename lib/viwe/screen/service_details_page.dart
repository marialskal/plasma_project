import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_chat/contoller/servaces_detales_controller.dart';
import 'package:scholar_chat/core/constant/color.dart';

class ServiceDetailsPage extends StatelessWidget {
  final int serviceId;

  const ServiceDetailsPage({Key? key, required this.serviceId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ServiceDetailsController());
    controller.fetchServiceById(serviceId);

    return Scaffold(
      body: Obx(() {
        if (controller.loading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final service = controller.service.value;

        if (service == null) {
          return const Center(child: Text("فشل في جلب تفاصيل الخدمة"));
        }

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
              child: Container(color: Colors.white.withOpacity(0.1)),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                  Center(
  child: ClipRRect(
    borderRadius: BorderRadius.circular(150),
    child: Image.network(
      service.iconUrl ?? "https://via.placeholder.com/150",
      height: 250,
      width: 250,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(
          "images/mm.jpg",
          height: 250,
          width: 250,
          fit: BoxFit.cover,
        );
      },
    ),
  ),
),

                    const SizedBox(height: 20),
                    Center(
                      child: Text(
                        service.name,
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: AppColor.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.card_giftcard, color: Colors.orange),
                            const SizedBox(width: 6),
                            Text("${service.points} نقطة", style: const TextStyle(fontSize: 16)),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.attach_money, color: Colors.teal[800]),
                            const SizedBox(width: 6),
                            Text(
                              "${service.price} \$",
                              style: TextStyle(fontSize: 16, color: Colors.teal[800]),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.timer, color: Colors.grey),
                            const SizedBox(width: 6),
                            Text(
                              "${service.duration} دقيقة",
                              style: const TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      "وصف الخدمة",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: AppColor.black),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      service.description,
                      style: const TextStyle(fontSize: 16, color: Colors.black54, height: 1.5),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.all(16),
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.self_improvement, color: AppColor.white),
                        label: const Text(
                          "احجز الآن",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColor.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          backgroundColor: AppColor.back,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          elevation: 20,
                          shadowColor: AppColor.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
