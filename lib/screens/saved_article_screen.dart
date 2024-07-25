import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/database/hive_storage.dart';
import 'package:myapp/modals/response_modal.dart';
import 'package:myapp/screens/articel_view.dart';
import 'package:myapp/utils/empty_space.dart';

class SaveArticle extends StatefulWidget {
  const SaveArticle({super.key});

  @override
  State<SaveArticle> createState() => _SaveArticleState();
}

class _SaveArticleState extends State<SaveArticle> {
  final HiveStorage _storage = HiveStorage();

  var list = [];

  @override
  void initState() {
    super.initState();
    list = _storage.getAllResponse();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        list;
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      list = _storage.getAllResponse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your saved article"),
      ),
      body: (list.isEmpty)
          ? Center(
              child: emptySpace(
                  title: "No articles bookmarked",
                  message:
                      "Bookmark articles to read anytime and without internet."),
            )
          : ListView.separated(
              separatorBuilder: (context, index) => const Divider(),
              itemCount: list.length,
              itemBuilder: (context, index) {
                ResponseBody response = list[index];
                debugPrint(response.url);
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ArticelView(
                          articleLink: response.url,
                          responseBody: response,
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 10),
                    child: listItem(response),
                  ),
                );
              },
            ),
    );
  }

  Widget listItem(ResponseBody response) {
    return Column(
      children: [
        listItemRowWithImage(response),
        const SizedBox(
          height: 10,
        ),
        Text(
          response.description,
          style: const TextStyle(
            color: Colors.grey,
          ),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        )
      ],
    );
  }

  Widget listItemRowWithImage(ResponseBody response) {
    return Row(
      key: Key(response.id),
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            textAlign: TextAlign.start,
            response.title,
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
            imageUrl: response.url,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
