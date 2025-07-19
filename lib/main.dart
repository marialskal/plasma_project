import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:scholar_chat/contoller/category_services_controller.dart';

import 'package:scholar_chat/core/services/services.dart';
import 'package:scholar_chat/firebase_options.dart';
import 'package:scholar_chat/language/translation_service.dart';
import 'package:scholar_chat/route.dart';
import 'package:scholar_chat/viwe/screen/LanguageScreen.dart';
import 'package:scholar_chat/viwe/screen/OnboardingScreen.dart';
import 'package:scholar_chat/viwe/screen/auth/loginScreen.dart';
import 'package:scholar_chat/provider/provider.dart'; 
import 'package:scholar_chat/contoller/favorit_controller.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
Get.put(FavoriteController(), permanent: true);
  Get.put(CategoryServicesController(), permanent: true);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await initServices();

  final myServices = Get.find<MyServices>();
  final prefs = myServices.sharedPreferences;

  String? langCode = prefs.getString('language_code');
  String? countryCode = prefs.getString('country_code');
  String? step = prefs.getString('step');

  Locale? startLocale;
  if (langCode != null && countryCode != null) {
    startLocale = Locale(langCode, countryCode);
  }


  Widget initialPage;
  if (langCode == null || countryCode == null) {
    initialPage = LanguageSelectionPage();
  } else if (step != "1") {
    initialPage = const OnboardingScreen();
  } else {
    initialPage = LoginScreen();
  }


  final uiProvider = UiProvider();
  await uiProvider.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<UiProvider>.value(value: uiProvider),
      ],
      child: MyApp(
        startLocale: startLocale,
        initialPage: initialPage,
      ),
    ),
  );
}

Future<void> initServices() async {
  await Get.putAsync(() => MyServices().init());
}

class MyApp extends StatelessWidget {
  final Locale? startLocale;
  final Widget initialPage;

  const MyApp({
    Key? key,
    this.startLocale,
    required this.initialPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Consumer<UiProvider>(
      builder: (context, uiProvider, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          translations: MyTranslations(),
          locale: startLocale ?? const Locale('en', 'US'),
          fallbackLocale: const Locale('en', 'US'),
          getPages: routes,
          theme: uiProvider.isDark ? uiProvider.darkTheme : uiProvider.lightTheme,
          home: initialPage,
        );
      },
    );
  }
}
