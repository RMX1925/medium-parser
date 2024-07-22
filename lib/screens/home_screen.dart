import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/screens/articel_view.dart';
import 'package:myapp/screens/not_valid_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final TextEditingController _controller = TextEditingController();

  void _showArticle(BuildContext context) {
    if (_controller.text.isEmpty) {
      return;
    }
    Navigator.of(context).push(CupertinoPageRoute(
        builder: (context) => ArticelView(
              articleLink: _controller.text.trim(),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    hintText: 'paste your medium url here',
                    
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                  ),
                  textAlign: TextAlign.center,
                  onSubmitted: (value) {
                    _showArticle(context);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: double.infinity,
                  child: MaterialButton(
                    onPressed: () {
                      _showArticle(context);
                    },
                    color: Colors.black,
                    colorBrightness: Brightness.dark,
                    padding: const EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Text("Read article"),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              if (kDebugMode)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    width: double.infinity,
                    child: MaterialButton(
                      onPressed: () {
                        openActivity(context);
                      },
                      colorBrightness: Brightness.light,
                      padding: const EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Text("Show not valid article"),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void openActivity(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => NotValidScreen(url: _controller.text)));
  }
}
