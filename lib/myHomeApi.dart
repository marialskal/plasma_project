import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:scholar_chat/model/department.dart';
import 'package:scholar_chat/model/offermodel.dart';
import 'package:scholar_chat/model/servicemodel.dart';

class MyHomeApi {
  static Future<List<CategoryModel>> getCategories() async {
    try {
      print("Starting getCategories...");

      var headers = {
        'Accept': 'application/json',
        'Authorization':
            'Bearer 14|a0rA2BjbfeFUHY8BAxU7rP7kGuhylS60uNw0A9lQb16e6c15',
      };

      print("Creating request to http://127.0.0.1:8000/api/departments");
      var request = http.MultipartRequest(
        'GET',
        Uri.parse('http://127.0.0.1:8000/api/departments'),
      );
      request.headers.addAll(headers);

      print("Sending request...");
      http.StreamedResponse response = await request.send();

      print("Response received. Status code: ${response.statusCode}");

      if (response.statusCode == 200) {
        print("Reading response body...");
        var responseData = await response.stream.bytesToString();

        print("Raw response body: $responseData");

        var decoded = json.decode(responseData);

        print("Decoded JSON: $decoded");

        List dataList = decoded['data'];

        print("Parsed data list with ${dataList.length} items.");

        List<CategoryModel> categories =
            dataList.map((json) => CategoryModel.fromJson(json)).toList();

        print("Converted to CategoryModel list successfully.");
        return categories;
      } else {
        print("Request failed with status: ${response.statusCode}");
      }
    } catch (e) {
      print("The Error is : $e");
    }

    print("Returning empty list due to error or non-200 response.");
    return [];
  }

  //...............
  static Future<CategoryModel?> getCategoryWithServices(int id) async {
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization':
            'Bearer 14|a0rA2BjbfeFUHY8BAxU7rP7kGuhylS60uNw0A9lQb16e6c15',
      };

      var request = http.MultipartRequest(
        'GET',
        Uri.parse('http://127.0.0.1:8000/api/departments/$id'),
      );
      request.headers.addAll(headers);

      var response = await request.send();

      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        var decoded = json.decode(responseData);
        return CategoryModel.fromJson(decoded['data']);
      }
    } catch (e) {
      print("Error fetching category services: $e");
    }
    return null;
  }

  //................

  static Future<ServiceModel?> getServiceById(int id) async {
    try {
      var response = await http.get(
        Uri.parse('http://127.0.0.1:8000/api/services/$id'),
        headers: {
          'Accept': 'application/json',
          'Authorization':
              'Bearer 14|a0rA2BjbfeFUHY8BAxU7rP7kGuhylS60uNw0A9lQb16e6c15',
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body)['data'];
        return ServiceModel.fromJson(data);
      }
    } catch (e) {
      print("getServiceById error: $e");
    }
    return null;
  }

///////////////////العروص
  static Future<List<OfferModel>> getOffers() async {
    try {
      print("Fetching offers...");

      var headers = {
        'Accept': 'application/json',
        'Authorization':
            'Bearer 14|a0rA2BjbfeFUHY8BAxU7rP7kGuhylS60uNw0A9lQb16e6c15',
      };

      var request = http.MultipartRequest(
        'GET',
        Uri.parse('http://127.0.0.1:8000/api/offers'),
      );
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        var decoded = json.decode(responseData);

        List dataList = decoded['data'];

        return dataList.map((json) => OfferModel.fromJson(json)).toList();
      } else {
        print("Request failed with status: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching offers: $e");
    }

    return [];
  }

/////////////////////////////////
  static Future<Map<String, dynamic>?> getOfferDetails(int offerId) async {
    try {
      print("🔄 جاري جلب تفاصيل العرض رقم $offerId ...");

      var headers = {
        'Accept': 'application/json',
        'Authorization':
            'Bearer 14|a0rA2BjbfeFUHY8BAxU7rP7kGuhylS60uNw0A9lQb16e6c15',
      };

      var request = http.MultipartRequest(
        'GET',
        Uri.parse('http://127.0.0.1:8000/api/offers/$offerId'),
      );
      request.headers.addAll(headers);

      var response = await request.send();
      print("📡 كود الاستجابة: ${response.statusCode}");

      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        print("✅ تم جلب التفاصيل: $responseBody");

        var decoded = json.decode(responseBody);
        return decoded['data'];
      } else {
        print("❌ فشل في جلب التفاصيل، الكود: ${response.statusCode}");
      }
    } catch (e) {
      print("⚠️ خطأ أثناء جلب التفاصيل: $e");
    }
    return null;
  }

//////////////////////////////المفضلة
static Future<Map<String, dynamic>> toggleFavorite(int serviceId) async {
  final response = await http.post(Uri.parse("http://localhost:8000/api/favorite/toggle/$serviceId"));

  if (response.statusCode == 200) {
    // طبع استجابة السيرفر للديباغ
    print("Toggle favorite response: ${response.body}");
    return jsonDecode(response.body);
  } else {
    throw Exception("فشل في تعديل حالة المفضلة. رمز الحالة: ${response.statusCode}");
  }
}

}
