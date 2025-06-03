import 'package:flutter/material.dart';

class AppTheme {
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.grey.shade700,
    colorScheme: const ColorScheme.dark(
      primary: Colors.grey,
      secondary: Colors.white,
      surface: Colors.black,
      onPrimary: Colors.white,
      onSurface: Colors.white,
      outline: Colors.grey,
    ),
    scaffoldBackgroundColor: const Color(0xFF1C1C1C),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1C1C1C),
      elevation: 0,
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontFamily: 'Montserrat',
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Montserrat',
        color: Colors.white,
        fontSize: 16,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Montserrat',
        color: Colors.white,
        fontSize: 14,
      ),
    ),
    iconTheme: const IconThemeData(color: Colors.white),
  );
}