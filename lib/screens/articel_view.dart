import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/api/medium_api.dart';
import 'package:myapp/screens/not_valid_screen.dart';
import 'package:myapp/screens/parse_webview.dart';
// ignore: unused_import, depend_on_referenced_packages
import 'package:html/parser.dart';
import 'package:myapp/utils/loading_widget.dart';

class ArticelView extends StatefulWidget {
  const ArticelView({
    super.key,
    required this.articleLink,
  });

  final String articleLink;

  @override
  State<ArticelView> createState() => _ArticelViewState();
}

class _ArticelViewState extends State<ArticelView> {
  MediumApi api = MediumApi();

  late Future<String?> article;
  String title = "";

  Future<String?> getArticle() async {
    var response = await api.getArticle(widget.articleLink);

    if (response == null) {
      return response;
    }

    debugPrint("Got response");

    response = getFilteredResponse(response);
    return response;
  }

  String getFilteredResponse(String html) {
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

    var font_sans = body?.getElementsByClassName("font-sans");
    if (font_sans != null) {
      var children = font_sans.first.children;
      children[0].remove();
    }
    print("OUTER HTML: ${doc.outerHtml}");
    return doc.outerHtml;
  }

  // Future<String?> getArticle() async {
  //   var response = await api.getArticle(widget.articleLink);
  //   debugPrint("True contains : ${widget.articleLink}");

  //   if (response == null) {
  //     return response;
  //   }
  //   if (kDebugMode) print("completed response");
  //   String head = getHeadHTML(response);
  //   String article = getArticleHTML(response);

  //   String newHtml = '''
  //     <html>
  //       $head
  //       <body>
  //         $article
  //       </body>
  //     </html>
  //   ''';
  //   return newHtml;
  // }

  // String getHeadHTML(String response) {
  //   return getSubStringWithTagName(response, "<head>", "</head>");
  // }

  // String getArticleHTML(String response) {
  //   return getSubStringWithTagName(response, "<article", "</article>");
  // }

  // String getSubStringWithTagName(String response, String tagName,
  //     [String? endTagName]) {
  //   return response.substring(response.indexOf(tagName),
  //       endTagName != null ? response.indexOf(endTagName) : null);
  // }

  @override
  void initState() {
    super.initState();
    article = getArticle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        elevation: 0,
      ),
      body: FutureBuilder<String?>(
        future: article,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return loadingView();
          } else if (snapshot.hasData && snapshot.data != null) {
            var data = snapshot.data!;
            return ParseWebview(htmlString: data);
          } else {
            return NotValidScreen(url: widget.articleLink);
          }
        },
      ),
    );
  }
}
