import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_chat/contoller/category_services_controller.dart';
import 'package:scholar_chat/contoller/favorit_controller.dart';
import 'package:scholar_chat/core/constant/color.dart';
import 'service_details_page.dart';

class CategoryServicesPage extends StatefulWidget {
  final String categoryName;
  final int categoryId;

  const CategoryServicesPage({
    Key? key,
    required this.categoryName,
    required this.categoryId,
  }) : super(key: key);

  @override
  State<CategoryServicesPage> createState() => _CategoryServicesPageState();
}

class _CategoryServicesPageState extends State<CategoryServicesPage> {
  final CategoryServicesController controller =
      Get.put(CategoryServicesController());
  final FavoriteController favController = Get.put(FavoriteController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchCategoryWithServices(widget.categoryId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
        backgroundColor: AppColor.back,
        foregroundColor: Colors.white,
      ),
      body: Obx(() {
        if (controller.loading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final services = controller.category.value?.services ?? [];

        if (services.isEmpty) {
          return const Center(child: Text("لا توجد خدمات لهذا القسم"));
        }

        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
            childAspectRatio: 2 / 2.2,
          ),
          itemCount: services.length,
          itemBuilder: (context, index) {
            final service = services[index];

            return GestureDetector(
              onTap: () {
                Get.to(() => ServiceDetailsPage(serviceId: service.id));
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppColor.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: AppColor.back,
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.vertical(top: Radius.circular(16)),
                        child: service.iconUrl != null &&
                                service.iconUrl!.isNotEmpty
                            ? Image.network(service.iconUrl!, fit: BoxFit.cover)
                            : Image.asset("images/mm.jpg",
                                fit: BoxFit.cover),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                      child: Column(
                        children: [
                          Text(
                            service.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColor.black,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 6),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.card_giftcard,
                                      size: 18, color: Colors.yellow),
                                  const SizedBox(width: 4),
                                  Text('${service.points}',
                                      style: const TextStyle(fontSize: 14)),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.attach_money,
                                      size: 18, color: Colors.teal[800]),
                                  const SizedBox(width: 4),
                                  Text(service.price,
                                      style: TextStyle(
                                          color: Colors.teal[800], fontSize: 14)),
                                ],
                              ),
                              // ✅ زر القلب مربوط بالمفضلة (Obx للتحديث الفوري)
                              Obx(() {
                                final isFavorite =
                                    favController.isFavorite(service.id);
                                return GestureDetector(
                                  onTap: () =>
                                      favController.toggleFavorite(service.id),
                                  child: Icon(
                                    isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color:
                                        isFavorite ? Colors.red : Colors.grey,
                                  ),
                                );
                              }),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
