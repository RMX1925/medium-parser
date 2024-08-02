import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/database/hive_storage.dart';
import 'package:myapp/modals/response_modal.dart';
import 'package:myapp/utils/parse_response_code.dart';
import 'package:uuid/uuid.dart';

class ApiURL {
  static String freedium = "https://freedium.vercel.app";
  static String readCache = "https://readcache.xyz";
  static String freediumCFD = "https://freedium.cfd";
  static String testURL =
      "https://medium.com/@yasirquyoom/how-to-integrate-animated-google-maps-like-uber-lyft-didi-chuxing-ola-grab-and-yandex-taxi-8442bdf68755";
}

class ArticleModal {
  final String title;
  final String subtitle;
  final String imageURL;

  ArticleModal({
    required this.title,
    required this.subtitle,
    required this.imageURL,
  });
}

class MediumApi {
  var uuid = const Uuid();
  final HiveStorage _storage = HiveStorage();

  Future<ArticleModal?> _getMediumArticle(String url) async {
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var doc = parse(response.body);
      var metas = doc.getElementsByTagName("meta");
      String title = "", description = "", url = "";

      for (var meta in metas) {
        if (meta.attributes['name'] == "og:title") {
          title = meta.attributes['content'] ?? "";
        } else if (meta.attributes['name'] == "description") {
          description = meta.attributes['content'] ?? "";
        } else if (meta.attributes['property'] == "og:image") {
          debugPrint("HEre in the url tag");
          url = meta.attributes['content'] ?? "";
          debugPrint("HEre $url");
        }
      }

      return ArticleModal(title: title, subtitle: description, imageURL: url);
    } else {
      debugPrint("Not good response : ${response.statusCode}");
      return null;
    }
  }

  Future<ResponseBody> _getArticleFromCFD(String url) async {
    // vercel id : bom1::iad1::cnjj5-1721544910605-45897305edf1

    var headers = {
      'Host': 'freedium.cfd',
      'User-Agent': 'PostmanRuntime/7.40.0',
    };

    var response = await http.get(
      Uri.parse('${ApiURL.freediumCFD}/$url'),
      headers: headers,
    );

    // debugPrint(response.body);

    if (response.statusCode == 200) {
      var htmlString = _getFilteredResponse(response.body);
      return ResponseBody(
        response: htmlString,
        statusCode: response.statusCode,
      );
    } else {
      return ResponseBody(
        response: "",
        statusCode: response.statusCode,
      );
    }
  }

  Future<ResponseBody> _getArticleReadCache(String url) async {
    var apiURL = ApiURL.readCache;

    var body = jsonEncode({
      'url': url,
    });

    var headers = {
      'Host': 'readcache.xyz',
      'Content-Length': '${utf8.encode(body).length}',
      'Origin': ApiURL.readCache,
    };

    var response = await http.post(
      Uri.parse('$apiURL/api/p?url=$url'),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      var doc = parse(response.body);
      var htmlString = '''
            <html>
            ${doc.getElementsByTagName("head").first.outerHtml}
            <body>
            ${doc.getElementsByTagName("article").first.outerHtml}
            </body>
            </html>
        ''';

      return ResponseBody(
        response: htmlString,
        statusCode: response.statusCode,
        disableJavascript: true,
      );
    } else {
      return ResponseBody(
        response: "",
        statusCode: response.statusCode,
      );
    }
  }

  Future<ResponseBody> getArticle(String url) async {
    if (kDebugMode) {
      url = ApiURL.testURL;
      print("This is from API: $url");
    }
    if (_storage.isResponsePresent(url.hashCode.toString())) {
      return _storage.getResponse(url.hashCode.toString())!;
    }

    var response = await _getArticleFromCFD(url);
    if (response.statusCode != 200) {
      response = await _getArticleReadCache(url);
      debugPrint("From ReadCache");
    }

    if (response.statusCode != 200) {
      response = await _getArticleFreedium(url);
      debugPrint("From Freedium");
    }

    var articleInfo = await _getMediumArticle(url);
    if (articleInfo == null) {
      return ResponseBody(
        response: response.response,
        statusCode: response.statusCode,
        disableJavascript: response.disableJavascript,
      );
    } else {
      return ResponseBody(
        id: url.hashCode.toString(),
        title: articleInfo.title,
        url: articleInfo.imageURL,
        description: articleInfo.subtitle,
        response: response.response,
        statusCode: response.statusCode,
        disableJavascript: response.disableJavascript,
      );
    }
  }

  Future<ResponseBody> _getArticleFreedium(String url) async {
    var apiURL = "https://freedium.vercel.app";

    var body = jsonEncode({
      'url': url,
    });

    var headers = {
      'Host': 'freedium.vercel.app',
      'Content-Length': '${utf8.encode(body).length}',
      'Origin': 'https://freedium.vercel.app',
      'sec-fetch-dest': 'empty',
      'sec-fetch-mode': 'cors',
      'sec-fetch-site': 'same-origin',
    };

    var response = await http.post(
      Uri.parse('$apiURL/api/fetchBlog'),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      var htmlString = '''
            <html>
            ${getHeadHTML(response.body)}
            <body>
              ${getArticleHTML(response.body)}
            </body>
            </html>
        ''';

      return ResponseBody(
        response: htmlString,
        statusCode: response.statusCode,
      );
    } else {
      return ResponseBody(
        response: "",
        statusCode: response.statusCode,
      );
    }
  }

  String _getFilteredResponse(String html) {
    var doc = parse(html);

    var body = doc.body;

    var notification = body?.getElementsByClassName("notification-container");
    if (notification != null) {
      notification.first.remove();
    }

    var navigation = body?.getElementsByTagName("nav");
    if (navigation != null) {
      navigation.first.remove();
    }

    var twoButtons = body?.children;
    if (twoButtons != null || twoButtons!.isNotEmpty) {
      twoButtons[0].remove();
    }

    var fontSans = body?.getElementsByClassName("font-sans");
    if (fontSans != null) {
      var children = fontSans.first.children;
      children[0].remove();
    }

    return doc.outerHtml;
  }
}
