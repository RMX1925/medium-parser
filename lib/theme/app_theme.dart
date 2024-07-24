import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/theme/app_color.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primarySwatch: blackColor,
    primaryColor: blackColor,
    brightness: Brightness.light,
    scaffoldBackgroundColor: whiteColor,
    appBarTheme: AppBarTheme(
      backgroundColor: whiteColor,
      titleTextStyle:
          GoogleFonts.libreBaskerville().copyWith(color: blackColor),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      focusColor: Colors.black,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
    ),
    primaryTextTheme: GoogleFonts.libreBaskervilleTextTheme(),
    buttonTheme: ButtonThemeData(
      minWidth: double.infinity,
      buttonColor: Colors.black,
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
    ),
    // inputDecorationTheme: InputDecorationTheme(
    //   border: OutlineInputBorder(),
    //   focusedBorder: OutlineInputBorder(
    //     borderSide: BorderSide(color: Colors.blue),
    //   ),
    // ),
  );

  static final ThemeData darkTheme = ThemeData(
    primarySwatch: whiteColor,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: blackColor,
    appBarTheme: AppBarTheme(
      backgroundColor: blackAccentColor,
      titleTextStyle: GoogleFonts.libreBaskerville(),
    ),
    primaryTextTheme: GoogleFonts.libreBaskervilleTextTheme(),
    inputDecorationTheme: const InputDecorationTheme(
      focusColor: Colors.white70,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
    ),

    buttonTheme: ButtonThemeData(
      minWidth: double.infinity,
      buttonColor: Colors.white70,
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
    ),
    // inputDecorationTheme: InputDecorationTheme(
    //   border: OutlineInputBorder(),
    //   focusedBorder: OutlineInputBorder(
    //     borderSide: BorderSide(color: Colors.blue),
    //   ),
    // ),
  );
}
