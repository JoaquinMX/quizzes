import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var appTheme = ThemeData(
  fontFamily: GoogleFonts.nunito().fontFamily,
  brightness: Brightness.dark,
  textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(color: Colors.grey),
      bodyLarge: TextStyle(fontSize: 18),
      bodyMedium: TextStyle(fontSize: 16),
      labelLarge: TextStyle(
        letterSpacing: 1.5,
        fontWeight: FontWeight.bold,
      )),
  buttonTheme: const ButtonThemeData(),
  bottomAppBarTheme: const BottomAppBarTheme(color: Colors.black87),
);
