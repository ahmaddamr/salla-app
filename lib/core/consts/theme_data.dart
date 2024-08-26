import 'package:flutter/material.dart';

class ThemeStyle {
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xff1E1E1E),
    scaffoldBackgroundColor: const Color(0xff1E1E1E),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xff1E1E1E),
      secondary: Colors.white,
    ),
    
  );

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(
      primary: Colors.white,
      secondary: Colors.black,
    ),
  );
}
