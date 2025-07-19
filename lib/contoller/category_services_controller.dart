import 'package:get/get.dart';
import 'package:scholar_chat/model/department.dart';
import 'package:scholar_chat/model/servicemodel.dart';
import 'package:scholar_chat/myHomeApi.dart';

class CategoryServicesController extends GetxController {
  RxBool loading = true.obs;
  Rx<CategoryModel?> category = Rx<CategoryModel?>(null);

  Future<List<ServiceModel>> fetchCategoryWithServices(int id) async {
  loading.value = true;
  final result = await MyHomeApi.getCategoryWithServices(id);
  category.value = result;
  loading.value = false;
  return result?.services ?? [];
}

Future<void> toggleFavorite(int serviceId) async {
    try {
      final response = await MyHomeApi.toggleFavorite(serviceId);
      if (response['message'] != null) {
        Get.snackbar("نجاح", response['message']);
      }
    } catch (e) {
      Get.snackbar("خطأ", "تعذر تعديل المفضلة");
    }
  }

}
