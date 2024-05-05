import 'package:flutter/material.dart';

ThemeData colorTheme(context) {
  if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
    return ThemeData(
      colorScheme: const ColorScheme.dark(
          primary: Color(0xFF0F0F0F),
          secondary: Color(0xFFF0F0F0),
          tertiary: Color(0xFF090c9b),
          outline: Color(0xFF5AF705),
          brightness: Brightness.light),
      useMaterial3: true,
    );
  } else {
    return ThemeData(
      colorScheme: const ColorScheme.light(
        primary: Color(0xFFF0F0F0),
        secondary: Color(0xFF0F0F0F),
        tertiary: Color(0xFF090c9b),
        outline: Color(0xFF5AF705),
        brightness: Brightness.dark,
      ),
      useMaterial3: true,
    );
  }
}

TextTheme textTheme(context) {
  return TextTheme(
      titleLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w900,
          color: Theme.of(context).colorScheme.secondary,
          fontFamily: 'Arial'));
}
