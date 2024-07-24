import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/database/hive_storage.dart';
import 'package:myapp/modals/response_modal.dart';
import 'package:myapp/screens/articel_view.dart';
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
                  itemBuilder: (context, index) {
                    debugPrint(data[index].url);
                    return InkWell(
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
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          key: Key(data[index].id),
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                textAlign: TextAlign.start,
                                data[index].title,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.actor().copyWith(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              clipBehavior: Clip.hardEdge,
                              child: CachedNetworkImage(
                                width: 100,
                                imageUrl: data[index].url,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            }
            return loadingView();
          },
        ));
  }
}
