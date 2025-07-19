// import 'dart:convert';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:dartz/dartz.dart';
// import 'package:untitled2/core/class/statusrequest.dart';

// class Crud {
//   Future<Either<StatusRequest, Map>> postData(String linkurl, Map data) async {
//       if (true) {
//         var response = await http.post(Uri.parse(linkurl), body: data);
//         print(response.statusCode);
//         if (response.statusCode == 200||response.statusCode == 1||response.statusCode == 201) {
//           Map responsebody = jsonDecode(response.body);
//           return Right(responsebody);
//         } 
//         else {
//             Get.defaultDialog(title: "ُWarning" , middleText: "Email Or Password Not Correct"); 
//           return const Left(StatusRequest.serverfailure);
//         }
//       }

//   }
// }
