import 'package:flutter/material.dart';

ThemeData lightTheme(context) {
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

ThemeData darkTheme(context) {
  return ThemeData(
    colorScheme: const ColorScheme.dark(
        primary: Color(0xFF0F0F0F),
        secondary: Color(0xFFF0F0F0),
        tertiary: Color(0xFF0F13FF),
        outline: Color(0xFF5AF705),
        brightness: Brightness.light),
    useMaterial3: true,
  );
}

TextTheme textTheme(context) {
  return TextTheme(
      titleLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w900,
          color: Theme.of(context).colorScheme.secondary,
          fontFamily: 'Arial'),
      labelLarge: TextStyle(
          fontSize: 23,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).colorScheme.secondary,
          fontFamily: 'Arial'),
      labelMedium: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).colorScheme.secondary,
          fontFamily: 'Arial'),
      displayLarge: TextStyle(
          fontSize: 42,
          fontWeight: FontWeight.w900,
          color: Theme.of(context).colorScheme.secondary,
          fontFamily: 'Arial'),
      displayMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).colorScheme.secondary,
          fontFamily: 'Arial'),
      displaySmall: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).colorScheme.secondary,
          fontFamily: 'Arial'),
      bodyMedium: TextStyle(
          fontSize: 21,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).colorScheme.secondary,
          fontFamily: 'Arial'));
}
