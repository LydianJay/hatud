import 'package:flutter/material.dart';

class AppTheme {
  // 🌗 Define light and dark themes
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color.fromRGBO(0, 64, 192, 1),
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(
      primary: Color.fromRGBO(0, 64, 192, 1),
      secondary: Color.fromRGBO(49, 164, 41, 1),
    ),
    fontFamily: 'Poppins',
    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(fontSize: 16, color: Colors.white),
      labelMedium: TextStyle(
        fontSize: 16,
        color: Colors.white,
        fontStyle: FontStyle.normal,
      ),
      labelLarge: TextStyle(
        fontSize: 24,
        color: Colors.white,
        fontStyle: FontStyle.normal,
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.blueGrey,
    colorScheme: const ColorScheme.dark(
      primary: Colors.blueGrey,
      secondary: Colors.tealAccent,
    ),
    fontFamily: 'Poppins',
    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(fontSize: 16),
    ),
  );
}
