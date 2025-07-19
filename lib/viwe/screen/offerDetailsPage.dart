
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_chat/contoller/offer_details_controller.dart';
import 'package:scholar_chat/core/constant/color.dart';
import 'package:scholar_chat/core/constant/color.dart';

class OfferDetailsPage extends StatefulWidget {
  final int offerId;

  const OfferDetailsPage({Key? key, required this.offerId}) : super(key: key);

  @override
  State<OfferDetailsPage> createState() => _OfferDetailsPageState();
}

class _OfferDetailsPageState extends State<OfferDetailsPage>
    with SingleTickerProviderStateMixin {
  final OfferDetailsController controller = Get.put(OfferDetailsController());

  double _scale = 1.0;

  void _onTapDown(TapDownDetails details) {
    setState(() => _scale = 1.05);
  }

  void _onTapUp(TapUpDetails details) {
    setState(() => _scale = 1.0);
  }

  void _onTapCancel() {
    setState(() => _scale = 1.0);
  }

  @override
  void initState() {
    super.initState();
  
    controller.fetchOfferDetails(widget.offerId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("تفاصيل العرض"),
        backgroundColor: AppColor.back,
        foregroundColor: AppColor.white,
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.loading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.offerDetails.isEmpty) {
          return const Center(
            child: Text("❌ لم يتم العثور على تفاصيل هذا العرض"),
          );
        }

        var offer = controller.offerDetails;
        return _buildUI(offer);
      }),
    );
  }

  Widget _buildUI(Map<String, dynamic> offer) {
    String name = offer["name"] ?? "بدون اسم";
    String? image = offer["image"];
    String description = offer["description"] ??
        "خدمة مميزة توفر لك الراحة والجمال. خبراؤنا يستخدمون منتجات عالية الجودة لضمان أفضل النتائج.";
    String discount = offer["discount_percentage"]?.toString() ?? "0";
    String start = offer["start_datetime"] ?? "";
    String end = offer["end_datetime"] ?? "";
    int points = offer["points"] ?? 0;
    String price = offer["price"]?.toString() ?? "150";
    String duration = offer["duration"] ?? "60 دقيقة";

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
            color: Colors.white.withOpacity(0.1),
          ),
        ),
        Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 80),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                      child: GestureDetector(
                        onTapDown: _onTapDown,
                        onTapUp: _onTapUp,
                        onTapCancel: _onTapCancel,
                        child: AnimatedScale(
                          duration: const Duration(milliseconds: 300),
                          scale: _scale,
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                )
                              ],
                            ),
                            child: (image != null)
    ? Image.network(
        "http://127.0.0.1:8000/uploads/$image",
        width: double.infinity,
        height: 250,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            "images/mm.jpg",
            width: double.infinity,
            height: 250,
            fit: BoxFit.cover,
          );
        },
      )
    : Container(
        height: 250,
        color: Colors.grey[300],
        child: const Icon(Icons.image_not_supported, size: 80),
      ),

                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                       
                          Text(
                            name,
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 82, 80, 78),
                            ),
                          ),
                          const SizedBox(height: 12),

                          Row(
                            children: [
                              const Icon(Icons.card_giftcard,
                                  color: Colors.amber, size: 22),
                              const SizedBox(width: 8),
                              Text(
                                "اكسب $points نقطة عند الحجز",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                        
                          Row(
                            children: [
                              const Icon(Icons.timer,
                                  size: 20, color: Colors.grey),
                              const SizedBox(width: 6),
                              Text(
                                duration,
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.grey),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                  
                          Text(
                            description,
                            style: const TextStyle(
                              fontSize: 16,
                              height: 1.5,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 20),

                    
                          Row(
                            children: [
                              Icon(Icons.attach_money,
                                  color: Colors.teal[800]),
                              const SizedBox(width: 6),
                              Text(
                                "$price",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.teal[800],
                                ),
                              ),
                              const SizedBox(width: 20),
                              Text(
                                "خصم $discount%",
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.redAccent,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                      
                          Text("تاريخ البداية: $start",
                              style: const TextStyle(color: Colors.black54)),
                          Text("تاريخ النهاية: $end",
                              style: const TextStyle(color: Colors.black54)),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(16),
              child: ElevatedButton.icon(
                onPressed: () {
             
                },
                icon: const Icon(Icons.self_improvement, color: AppColor.back),
                label: const Text(
                  "احجز الآن",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColor.back),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: AppColor.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 10,
                  shadowColor: AppColor.back,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}