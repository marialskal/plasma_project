import 'package:get/get.dart';
import 'package:scholar_chat/myHomeApi.dart';

class OfferDetailsController extends GetxController {
  RxBool loading = false.obs;
  RxMap<String, dynamic> offerDetails = <String, dynamic>{}.obs;

  Future<void> fetchOfferDetails(int offerId) async {
    loading.value = true;
    var details = await MyHomeApi.getOfferDetails(offerId);
    if (details != null) {
      offerDetails.value = details;
      print(" تم تحميل تفاصيل العرض: ${offerDetails['name']}");
    }
    loading.value = false;
  }
}