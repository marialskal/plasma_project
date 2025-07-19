import 'package:http/http.dart'as http;
import 'package:scholar_chat/contoller/shared_prefs.dart';

class deleteApi{
  static Future<bool> deleteFavorite(int id)async{
        var token = await MyInfoPrefs.getInfo(name: 'token');
    print('Token Amer :$token');
  var headers = {
  'Accept': 'application/json',
  'Authorization': 'Bearer $token'
};
var request = http.Request('DELETE', Uri.parse('http://localhost:8000/api/favorite/toggle/$id'));

request.headers.addAll(headers);

http.StreamedResponse response = await request.send();

if (response.statusCode == 200) {
  print(await response.stream.bytesToString());
  return true;
}
else {
  print(response.reasonPhrase);
  return false;
}

  }
}