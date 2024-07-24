import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget emptySpace({
  required String title,
  required String message,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        title,
        textAlign: TextAlign.center,
        style: GoogleFonts.libreBaskerville().copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: GoogleFonts.actor().copyWith(
            fontSize: 18,
          ),
        ),
      ),
    ],
  );
}
