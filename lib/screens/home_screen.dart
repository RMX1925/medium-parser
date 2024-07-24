import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/database/hive_storage.dart';
import 'package:myapp/modals/not_valid_data.dart';
import 'package:myapp/screens/articel_view.dart';
import 'package:myapp/screens/not_valid_screen.dart';
import 'package:myapp/screens/saved_article_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final TextEditingController _controller = TextEditingController();

  void _showArticle(BuildContext context) {
    if (_controller.text.isEmpty && !kDebugMode) {
      return;
    }
    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (context) => ArticelView(
          articleLink: _controller.text.trim(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(
                flex: 2,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Humans\nstories & ideas",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.libreBaskerville().copyWith(
                      fontSize: 40,
                      fontWeight: FontWeight.w500,
                      height: 1,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    hintText: 'paste your medium url here',
                    suffixIcon: IconButton(
                      onPressed: () {
                        _controller.text = "";
                      },
                      icon: const Icon(
                        CupertinoIcons.clear_circled_solid,
                      ),
                    ),
                  ),
                  textAlign: TextAlign.center,
                  onSubmitted: (value) {
                    _showArticle(context);
                  },
                  onTap: () {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: MaterialButton(
                  onPressed: () {
                    _showArticle(context);
                  },
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.black
                      : Colors.white70,
                  colorBrightness: Theme.of(context).brightness,
                  padding: const EdgeInsets.all(20),
                  child: const Text("Read article"),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              if (kDebugMode) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: MaterialButton(
                    onPressed: () {
                      openActivity(context);
                    },
                    padding: const EdgeInsets.all(20),
                    colorBrightness: Theme.of(context).brightness,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.black
                            : Colors.white70,
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Text("Show not valid article"),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: MaterialButton(
                    onPressed: () {
                      HiveStorage().deleteAllResponse();
                    },
                    padding: const EdgeInsets.all(20),
                    colorBrightness: Theme.of(context).brightness,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.black
                            : Colors.white70,
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Text("Delete database"),
                  ),
                ),
              ],
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: MaterialButton(
                  onPressed: () {
                    _openSavedView(context);
                  },
                  padding: const EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : Colors.white70,
                    ),
                  ),
                  child: Text(
                    "Your saved article",
                    style: GoogleFonts.libreBaskerville().copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  "version 1.0.1",
                  style: GoogleFonts.libreBaskerville(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void openActivity(BuildContext context) {
    var message =
        NotValidMessage(title: "title", message: "message", url: "url");
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NotValidScreen(
          message: message,
        ),
      ),
    );
  }

  void _openSavedView(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const SaveArticle(),
      ),
    );
  }
}
