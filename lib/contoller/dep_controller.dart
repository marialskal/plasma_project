import 'package:get/get.dart';

import 'package:scholar_chat/model/department.dart';
import 'package:scholar_chat/myHomeApi.dart';

class CategoryController extends GetxController {
  RxBool loading = true.obs;
  RxList<CategoryModel> categories = <CategoryModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  fetchCategories() async {
    loading.value = true;
    categories.value = await MyHomeApi.getCategories();
    loading.value = false;
  }
}