import 'package:get/get.dart';
import 'package:scholar_chat/model/offermodel.dart';
import 'package:scholar_chat/myHomeApi.dart';

class OfferController extends GetxController {
  RxBool loading = true.obs;
  RxList<OfferModel> offers = <OfferModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    print("بدأ تحميل العروض...");
    fetchOffers();
  }

  fetchOffers() async {
    loading.value = true;
    print("جاري جلب العروض من API...");
    try {
      offers.value = await MyHomeApi.getOffers();
      print("تم جلب عدد العروض: ${offers.length}");
      if (offers.isNotEmpty) {
        print("أول عرض: ${offers[0].name} - الصورة: ${offers[0].image}");
      }
    } catch (e) {
      print("حدث خطأ أثناء جلب العروض: $e");
    }
    loading.value = false;
    print("انتهى تحميل العروض.");
  }
}