import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class ParseWebview extends StatefulWidget {
  const ParseWebview({
    super.key,
    required this.htmlString,
    this.disableJavascript = false,
  });

  final String htmlString;
  final bool disableJavascript;

  @override
  State<ParseWebview> createState() => _ParseWebviewState();
}

class _ParseWebviewState extends State<ParseWebview> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();

    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams();
    } else {
      params = AndroidWebViewControllerCreationParams();
    }

    var javascriptMode = widget.disableJavascript
        ? JavaScriptMode.disabled
        : JavaScriptMode.unrestricted;

    controller = WebViewController.fromPlatformCreationParams(params)
      ..setJavaScriptMode(javascriptMode)
      ..setBackgroundColor(Colors.white10)
      ..setUserAgent(
          "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36")
      ..loadHtmlString(widget.htmlString);
    // ..runJavaScriptReturningResult('''
    //   var notification = document.getElementsByClassName("notification-container").first;
    //   notification.remove();
    //   var notification = document.getElementsByClassName("font-sans").first;
    //   notification.remove();
    //   var nav = document.getElementsByTagName("nav").first;
    //   nav.remove();
    // ''');

    // controller.setNavigationDelegate(
    //   NavigationDelegate(
    //     onPageFinished: (url) async {
    //       var result = await controller.runJavaScriptReturningResult('''
    //         var notification = document.getElementsByClassName("notification-container")[0];
    //         notification.remove();
    //         var nav = document.getElementsByTagName("nav")[0];
    //         nav.remove();
    //       ''');
    //       debugPrint("RESULT OF JAVASCRIPT : $result");
    //     },
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: controller);
  }
}
