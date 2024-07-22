import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiURL {
  static String freedium = "https://freedium.vercel.app";
  static String readCache = "https://readcache.xyz";
  static String freediumCFD = "https://freedium.cfd";
}

class MediumApi {
  Future<String?> getArticle(String url) async {
    if (kDebugMode) {
      print("This is from API: $url");
    }

    // vercel id : bom1::iad1::cnjj5-1721544910605-45897305edf1

    var headers = {
      'Host': 'freedium.cfd',
      'User-Agent': 'PostmanRuntime/7.40.0',
    };

    var response = await http.get(
      Uri.parse('${ApiURL.freediumCFD}/$url'),
      headers: headers,
    );

    debugPrint(response.body);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  // Future<String?> getArticle(String url) async {
  //   if (kDebugMode) {
  //     print("This is from API: $url");
  //   }
  //   var apiURL = "https://freedium.vercel.app";

  //   var body = jsonEncode({
  //     'url': url,
  //   });

  //   var headers = {
  //     'Host': 'freedium.vercel.app',
  //     'Content-Length': '${utf8.encode(body).length}',
  //     'Origin': 'https://freedium.vercel.app',
  //     'sec-fetch-dest': 'empty',
  //     'sec-fetch-mode': 'cors',
  //     'sec-fetch-site': 'same-origin',
  //   };

  //   var response = await http.post(
  //     Uri.parse('$apiURL/api/fetchBlog'),
  //     headers: headers,
  //     body: body,
  //   );

  //   print(response.body);

  //   if (response.statusCode == 200) {
  //     var responseString = response.body;
  //     return responseString;
  //   } else {
  //     return null;
  //   }
  // }
}
