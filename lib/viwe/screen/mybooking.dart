import 'dart:ui';
import 'package:flutter/material.dart';

import '../../core/constant/color.dart';



class MyBookingsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> bookings = [
    {
      "image": "https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=800&q=80",
      "name": "جلسة ليزر",
      "date": "2025-06-20",
      "time": "3:00 م"
    },
    {
      "image": "https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=800&q=80",
      "name": "تنظيف بشرة",
      "date": "2025-06-25",
      "time": "12:00 ظ"
    },
    {
      "image": "https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=800&q=80",
      "name": "جلسة تجميل",
      "date": "2025-06-30",
      "time": "6:00 م"
    },
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
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

          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView.builder(
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                final booking = bookings[index];
                return Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                        child: Image.network(
                          booking["image"],
                          height: 100,
                          width: width * 0.3,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(booking["name"], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 5),
                              Text("📅 التاريخ: ${booking["date"]}", style: const TextStyle(fontSize: 14)),
                              Text("⏰ الساعة: ${booking["time"]}", style: const TextStyle(fontSize: 14)),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
