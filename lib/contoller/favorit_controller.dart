import 'package:get/get.dart';
import 'package:scholar_chat/model/servicemodel.dart';
import 'package:scholar_chat/myHomeApi.dart';

class FavoriteController extends GetxController {

  RxList<int> favoriteIds = <int>[].obs;

  Future<void> toggleFavorite(int serviceId) async {
  try {
    final response = await MyHomeApi.toggleFavorite(serviceId);

    if (response['message'] == "تمت إضافة الخدمة إلى المفضلة") {
      if (!favoriteIds.contains(serviceId)) {
        favoriteIds.add(serviceId);
      }
    } else {
      favoriteIds.remove(serviceId);
    }
  } catch (e) {
    print("Error toggling favorite: $e");  
    Get.snackbar("خطأ", "تعذر تعديل المفضلة");
  }
}


  /// هل الخدمة مفضلة؟
  bool isFavorite(int serviceId) => favoriteIds.contains(serviceId);

  /// فلترة قائمة الخدمات وإرجاع المفضلات فقط
  List<ServiceModel> filterFavorites(List<ServiceModel> allServices) {
    return allServices.where((s) => favoriteIds.contains(s.id)).toList();
  }
}
