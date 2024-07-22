import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotValidScreen extends StatelessWidget {
  const NotValidScreen({
    super.key,
    required this.url,
  });

  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Unable to open!",
              style: GoogleFonts.libreBaskerville().copyWith(
                fontSize: 40,
                fontWeight: FontWeight.w500,
                height: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'The url',
                  children: [
                    TextSpan(
                      text: ' $url ',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const TextSpan(
                      text: "is not valid. Please choose a valid medium url.",
                    ),
                  ],
                  style: GoogleFonts.dmSans().copyWith(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
