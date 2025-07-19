

import 'package:get/get.dart';
import 'package:scholar_chat/language/arab.dart';
import 'package:scholar_chat/language/eng.dart';



class MyTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': en,
        'ar_AR': ar,
      };
}
