import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/screens/articel_view.dart';
import 'package:myapp/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

// void navigateToScreen(String link) {
//   MyApp.navigatorKey.currentState?.pushNamed("/article", arguments: link);
// }

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  late AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;

  @override
  void initState() {
    super.initState();
    initDeepLinks();
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();
    super.dispose();
  }

  Future<void> initDeepLinks() async {
    _appLinks = AppLinks();

    // Handle links
    _linkSubscription = _appLinks.uriLinkStream.listen((uri) {
      debugPrint('onAppLink: $uri');
      openAppLink(uri);
    });
  }

  void openAppLink(Uri uri) {
    _navigatorKey.currentState
        ?.pushNamed("/article", arguments: uri.toString());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      title: 'Medium Bypasser',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ThemeData(
        textTheme: GoogleFonts.dmSansTextTheme(),
        primaryColor: Colors.black,
      ),
      initialRoute: "/",
      onGenerateRoute: (settings) {
        Widget currentWidget = HomeScreen();

        // Mimic web routing
        final routeName = settings.name;
        if (routeName != null) {
          if (routeName.contains("/article")) {
            currentWidget = ArticelView(
              articleLink: settings.arguments as String,
            );
          }
        }

        return MaterialPageRoute(
          builder: (context) => currentWidget,
          settings: settings,
          fullscreenDialog: false,
        );
      },
    );
  }
}
