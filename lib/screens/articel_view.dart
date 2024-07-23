import 'package:flutter/material.dart';
import 'package:myapp/api/medium_api.dart';
import 'package:myapp/modals/not_valid_data.dart';
import 'package:myapp/modals/response_modal.dart';
import 'package:myapp/screens/not_valid_screen.dart';
import 'package:myapp/screens/parse_webview.dart';
import 'package:myapp/utils/loading_widget.dart';
import 'package:myapp/utils/parse_response_code.dart';

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

  late Future<ResponseBody> article;
  String title = "";

  Future<ResponseBody> getArticle() async {
    return await api.getArticle(widget.articleLink);

    // if (responseBody.statusCode != 200) {
    //   // handle error

    //   return responseBody;
    // }

    // var response = responseBody.response;

    // if (response.isEmpty) {
    //   return null;
    // }

    // debugPrint("Got response");

    // // response = getFilteredResponse(response);
    // return response;
  }

  @override
  void initState() {
    super.initState();
    article = getArticle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: FutureBuilder<ResponseBody>(
        future: article,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return loadingView();
          } else if (snapshot.hasData && snapshot.data != null) {
            var response = snapshot.data!;
            if (response.statusCode == 200) {
              return Theme(
                data: Theme.of(context),
                child: ParseWebview(
                  htmlString: response.response,
                  disableJavascript: response.disableJavascript,
                ),
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
}
