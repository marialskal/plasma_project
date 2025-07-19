// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:scholar_chat/contoller/category_services_controller.dart';
// import 'package:scholar_chat/contoller/favorit_controller.dart';

// class FavoritePage extends StatelessWidget {
//   
//   final FavoriteController favController = Get.find<FavoriteController>();

//   @override
//   Widget build(BuildContext context) {
//     final allServices = Get.find<CategoryServicesController>().category.value?.services ?? [];

//     return Scaffold(
//       appBar: AppBar(title: Text("المفضلة")),
//       body: Obx(() {
//         final favServices = favController.filterFavorites(allServices);

//         if (favServices.isEmpty) {
//           return Center(child: Text("لا توجد مفضلات بعد"));
//         }

//         return ListView.builder(
//           itemCount: favServices.length,
//           itemBuilder: (context, index) {
//             final service = favServices[index];
//             return ListTile(
//               title: Text(service.name),
//               leading: service.iconUrl != null
//                   ? Image.network(service.iconUrl!)
//                   : Icon(Icons.image),
//               trailing: Icon(Icons.favorite, color: Colors.red),
//             );
//           },
//         );
//       }),
//     );
//   }
// }
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:scholar_chat/provider.dart';
import 'package:scholar_chat/provider/provider.dart';

class AppColor {
  static const Color white = Colors.white;
  static const Color primaryColor = Color(0xFFFAF9F6); 
  static const Color black = Colors.black;
  static const Color back = Color(0xFFD8A165); 
}

class FavoritePage extends StatelessWidget {
  const FavoritePage();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

 
    final List<Map<String, String>> favoriteItems = [
      {
        "name": "Hair Coloring",
        "image":
            "https://images.unsplash.com/photo-1508214751196-bcfd4ca60f91?auto=format&fit=crop&w=800&q=80"
      },
      {
        "name": "Haircut & Styling",
        "image":
            "https://images.unsplash.com/photo-1522337660859-02fbefca4702?auto=format&fit=crop&w=800&q=80"
      },
      {
        "name": "Skin Care",
        "image":
            "https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=800&q=80"
      },
       {
        "name": "Hair Coloring",
        "image":
            "https://images.unsplash.com/photo-1508214751196-bcfd4ca60f91?auto=format&fit=crop&w=800&q=80"
      },
      {
        "name": "Haircut & Styling",
        "image":
            "https://images.unsplash.com/photo-1522337660859-02fbefca4702?auto=format&fit=crop&w=800&q=80"
      },
      {
        "name": "Skin Care",
        "image":
            "https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=800&q=80"
      },
    ];

    return Scaffold(
      body: Consumer<UiProvider>(
        builder: (context, UiProvider notifier, child) {
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
                  color:
                      const Color.fromARGB(255, 255, 255, 255).withOpacity(0.1),
                ),
              ),

              ListView(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: SizedBox(
                        width: width * 0.7,
                        height: width * 0.7,
                        child: Image.asset(
                          'images/fav.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: ListView.builder(
                      itemCount: favoriteItems.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final item = favoriteItems[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: AppColor.back,
                                blurRadius: 10,
                              
                              ),
                            ],
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(12),
                            onTap: () {
                            
                            },
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                item["image"]!,
                                width: width * 0.2,
                                height: height * 0.12,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text(
                              item["name"]!,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: AppColor.black,
                              ),
                            ),
                            trailing: const Icon(Icons.favorite,
                                color: AppColor.back),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
