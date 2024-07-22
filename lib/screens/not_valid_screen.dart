import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/modals/not_valid_data.dart';

class NotValidScreen extends StatelessWidget {
  const NotValidScreen({
    super.key,
    required this.message,
  });

  final NotValidMessage message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              message.title,
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
                  text: 'Given url : ',
                  children: [
                    TextSpan(
                      text: ' ${message.url}\n',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: message.message,
                    ),
                  ],
                  style: GoogleFonts.dmSans().copyWith(
                    fontSize: 18,
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.black
                        : Colors.white70,
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
