import 'package:get/get.dart';
import 'package:scholar_chat/model/servicemodel.dart';
import 'package:scholar_chat/myHomeApi.dart';

class ServiceDetailsController extends GetxController {
  RxBool loading = true.obs;
  Rx<ServiceModel?> service = Rx<ServiceModel?>(null);

  Future<void> fetchServiceById(int id) async {
    loading.value = true;
    final result = await MyHomeApi.getServiceById(id);
    service.value = result;
    loading.value = false;
  }

  
}
