import 'package:flutter/material.dart';
import 'package:myapp/database/hive_storage.dart';
import 'package:myapp/modals/response_modal.dart';
import 'package:myapp/screens/articel_view.dart';
import 'package:myapp/screens/parse_webview.dart';
import 'package:myapp/theme/app_color.dart';
import 'package:myapp/utils/empty_space.dart';
import 'package:myapp/utils/loading_widget.dart';

class SaveArticle extends StatefulWidget {
  const SaveArticle({super.key});

  @override
  State<SaveArticle> createState() => _SaveArticleState();
}

class _SaveArticleState extends State<SaveArticle> {
  final HiveStorage _storage = HiveStorage();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Your saved article"),
        ),
        body: FutureBuilder<List<ResponseBody>>(
          future: _storage.getAllResponse(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data;

              if (data == null || data.isEmpty) {
                return Center(
                  child: emptySpace(
                      title: "No articles bookmarked",
                      message:
                          "Bookmark articles to read anytime and without internet."),
                );
              }
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) => ListTile(
                  key: Key(data[index].id),
                  title: Text(
                    data[index].title,
                  ),
                  dense: true,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ArticelView(
                          articleLink: data[index].url,
                          responseBody: data[index],
                        ),
                      ),
                    );
                  },
                  shape: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? whiteAccentColor.withOpacity(0.5)
                          : blackAccentColor.withOpacity(0.5),
                    ),
                  ),
                  contentPadding: const EdgeInsets.all(10),
                ),
              );
            }
            return loadingView();
          },
        ));
  }
}
