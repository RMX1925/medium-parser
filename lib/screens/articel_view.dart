import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:myapp/api/medium_api.dart';
import 'package:myapp/database/hive_storage.dart';
import 'package:myapp/modals/not_valid_data.dart';
import 'package:myapp/modals/response_modal.dart';
import 'package:myapp/provider/theme_provider.dart';
import 'package:myapp/screens/not_valid_screen.dart';
import 'package:myapp/screens/parse_webview.dart';
import 'package:myapp/utils/loading_widget.dart';
import 'package:myapp/utils/parse_response_code.dart';
import 'package:myapp/utils/show_snackbar.dart';
import 'package:provider/provider.dart';

class ArticelView extends StatefulWidget {
  ArticelView({
    super.key,
    required this.articleLink,
    this.responseBody,
  });

  final String articleLink;
  ResponseBody? responseBody;

  @override
  State<ArticelView> createState() => _ArticelViewState();
}

class _ArticelViewState extends State<ArticelView> {
  MediumApi api = MediumApi();

  late Future<ResponseBody> article;
  String title = "";

  Future<ResponseBody> getArticle() async {
    return await api.getArticle(widget.articleLink);
  }

  final HiveStorage _storage = HiveStorage();

  bool isSaved = false;

  @override
  void initState() {
    super.initState();
    if (widget.responseBody != null) {
      article = Future.value(widget.responseBody!);
    } else {
      article = getArticle();
    }
    _isSaved(article);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () async {
              _saveOrDeleteResponse(context);
            },
            icon: Icon(
              isSaved
                  ? Icons.bookmark_added_rounded
                  : Icons.bookmark_add_outlined,
            ),
          ),
          // Consumer<ThemeProvider>(builder:
          //     (BuildContext context, ThemeProvider value, Widget? child) {
          //   return IconButton(
          //     onPressed: () {
          //       value.toggleTheme();
          //     },
          //     icon: Icon(
          //       value.isDarkTheme(context)
          //           ? Icons.dark_mode
          //           : Icons.light_mode_outlined,
          //     ),
          //   );
          // }),
        ],
      ),
      body: FutureBuilder<ResponseBody>(
        future: article,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return loadingView();
          } else if (snapshot.hasData && snapshot.data != null) {
            var response = snapshot.data!;
            if (response.statusCode == 200) {
              return ParseWebview(
                htmlString: response.response,
                disableJavascript: response.disableJavascript,
              );
            } else {
              var message = generateMessageForStatusCode(
                  response.statusCode, widget.articleLink);
              return NotValidScreen(message: message);
            }
          } else {
            var message = NotValidMessage(
                title: "Unable to open!",
                message:
                    "The url ${widget.articleLink} is either invalid or we are unable to open this.",
                url: widget.articleLink);
            return NotValidScreen(
              message: message,
            );
          }
        },
      ),
    );
  }

  _isSaved(Future<ResponseBody> article) async {
    var response = await article;
    if (_storage.isResponsePresent(response.id)) {
      setState(() {
        isSaved = true;
      });
    } else {
      setState(() {
        isSaved = false;
      });
    }
  }

  String? _getTitle(String response) {
    var doc = parse(response);
    return doc.getElementsByTagName("title").first.text;
  }

  void _saveOrDeleteResponse(BuildContext context) async {
    var response = await article;
    debugPrint("is saved: $isSaved");
    if (isSaved) {
      await _storage.deleteResponse(response.id);
      _isSaved(article);
      showSnackbar(context, message: "Article removed from bookmark");
      return;
    }
    if (response.response.isNotEmpty) {
      response.title = _getTitle(response.response) ?? "No Title";

      await _storage.saveArticle(response);
      _isSaved(article);
      showSnackbar(
        context,
        message: "Article saved to bookmark",
      );
    }
  }
}
