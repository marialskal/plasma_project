import 'package:get/get.dart';
import 'package:scholar_chat/core/constant/routs.dart';
import 'package:scholar_chat/viwe/screen/LanguageScreen.dart';
import 'package:scholar_chat/viwe/screen/OnboardingScreen.dart';
import 'package:scholar_chat/viwe/screen/auth/forgetpassword/forgetpassword.dart';
import 'package:scholar_chat/viwe/screen/auth/forgetpassword/resetpassword.dart';
import 'package:scholar_chat/viwe/screen/auth/forgetpassword/successresetpassword.dart';
import 'package:scholar_chat/viwe/screen/auth/loginScreen.dart';
import 'package:scholar_chat/viwe/screen/auth/signupScreen.dart';
import 'package:scholar_chat/viwe/screen/auth/successSignUp.dart';
import 'package:scholar_chat/viwe/screen/auth/verifyCodeSignUp.dart';
import 'package:scholar_chat/viwe/screen/category.dart';
import 'package:scholar_chat/viwe/screen/homepage.dart';
import 'package:scholar_chat/viwe/screen/offerDetailsPage.dart';

List<GetPage<dynamic>>? routes = [

   GetPage(name: AppRoute.onBoarding, page: () => const OnboardingScreen()), 
   GetPage(name: AppRoute.login, page: () => LoginScreen()),
// GetPage(name: "/" , page: ()=> const Language(),middlewares: [MyMiddleWare()] ),
   GetPage(name: AppRoute.signUp, page: () =>  SignUpScreen()),
   GetPage(name: AppRoute.forgetPassword, page: () =>  ForgetPassword()),
   GetPage(name: AppRoute.resetPassword, page: () =>  ResetPassword()),
   GetPage(name: "/", page: () =>  LanguageSelectionPage()),
   GetPage(name: AppRoute.successSignUp, page: () => const SuccessSignUp()),
   GetPage( name: AppRoute.succuessResetPassowrd,  page: () => const SuccuessResetPassowrd()),
   GetPage(name: AppRoute.verifycodesignup, page: () => const VerifyCodeSignUp()),
   GetPage(name: AppRoute.homescreen, page: () =>  Homepage()),
  // GetPage(name: AppRoute.offerdetailspage, page: () =>   OfferDetailsPage(offer: {},) ),
GetPage(
  name: AppRoute.categoryservicespage,
  page: () => CategoryServicesPage(categoryId: 0, categoryName: ''),
),

   

];
