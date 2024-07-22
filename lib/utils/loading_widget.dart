import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

Widget loadingView() {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const CupertinoActivityIndicator(
          radius: 20,
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          "Getting article",
          style: GoogleFonts.libreBaskerville().copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            height: 1,
          ),
        ),
      ],
    ),
  );
}
