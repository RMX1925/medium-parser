import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/provider/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class ParseWebview extends StatefulWidget {
  ParseWebview({
    super.key,
    required this.htmlString,
    this.disableJavascript = false,
    this.isDarkMode = false,
  });

  final String htmlString;
  final bool disableJavascript;
  final bool isDarkMode;

  @override
  State<ParseWebview> createState() => _ParseWebviewState();
}

class _ParseWebviewState extends State<ParseWebview> {
  late final WebViewController controller;

  late Brightness brightness = Theme.of(context).brightness;

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
      ..loadHtmlString(widget.htmlString)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (url) {
            // _setWebViewTheme(Theme.of(context).brightness == Brightness.dark);
            _setWebViewTheme(widget.isDarkMode);
          },
          onNavigationRequest: (request) {
            // WidgetsBinding.instance.addPostFrameCallback((duration) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(
                  "Redirect is not allowed",
                  style: GoogleFonts.libreBaskerville(),
                ),
                content: const Text(
                  "Redirects are prevented for anonymousity. Copy the link and try to open in your browser.",
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Ok"),
                  ),
                ],
              ),
            );
            // });
            return NavigationDecision.prevent;
          },
        ),
      )
      ..setUserAgent("PostmanRuntime/7.40.0");
  }

  void _setWebViewTheme(bool isDarkMode) {
    debugPrint("changeTheme : isDarkMode $isDarkMode");
    controller.runJavaScript(
      isDarkMode
          ? "document.documentElement.classList.add('dark');"
          : "document.documentElement.classList.remove('dark');",
    );
    // controller.runJavaScript(
    //   isDarkMode ? "changeTheme('devibeans');" : "changeTheme('a11y-light');",
    // );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var getBrightness = MediaQuery.of(context).platformBrightness;

    if (getBrightness != brightness) {
      _setWebViewTheme(getBrightness == Brightness.dark);
      brightness = getBrightness;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (BuildContext context, ThemeProvider value, Widget? child) {
        _setWebViewTheme(value.isDarkTheme);
        return WebViewWidget(controller: controller);
      },
    );
  }
}
