import 'package:flutter/material.dart';
import 'package:myapp/screens/saved_article_screen.dart';

void showSnackbar(BuildContext context,
    {required String message, void Function()? onUndoClick}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
      action: SnackBarAction(
          label: "View",
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (c) => const SaveArticle()));
          }),
    ),
  );
}
