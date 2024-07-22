import 'package:flutter/material.dart';

const Map<int, Color> blackColorMap = {
  50: Color(0xFFE0E0E0),
  100: Color(0xFFB3B3B3),
  200: Color(0xFF808080),
  300: Color(0xFF4D4D4D),
  400: Color(0xFF262626),
  500: Color(0xFF000000),
  600: Color(0xFF000000),
  700: Color(0xFF000000),
  800: Color(0xFF000000),
  900: Color(0xFF000000),
};

const Map<int, Color> whiteColorMap = {
  50: Color(0xFFFFFFFF),
  100: Color(0xFFFFFFFF),
  200: Color(0xFFFFFFFF),
  300: Color(0xFFFFFFFF),
  400: Color(0xFFFFFFFF),
  500: Color(0xFFFFFFFF),
  600: Color(0xFFE0E0E0),
  700: Color(0xFFB3B3B3),
  800: Color(0xFF808080),
  900: Color(0xFF4D4D4D),
};

MaterialColor blackColor =
    MaterialColor(blackColorMap[800]!.value, blackColorMap);
MaterialAccentColor blackAccentColor =
    MaterialAccentColor(blackColorMap[500]!.value, blackColorMap);

MaterialColor whiteColor =
    MaterialColor(whiteColorMap[500]!.value, whiteColorMap);
MaterialAccentColor whiteAccentColor =
    MaterialAccentColor(whiteColorMap[500]!.value, whiteColorMap);
