import 'package:flutter/material.dart';

class ThemeAssets {
  static Color darkBlue = const Color(0xFF003461);
  static Color lightBlue = const Color(0xFF0083CA);
  static Color teal = const Color(0xFF00AFAD);
  static Color orange = const Color(0xFFF26522);
  static Color amber = const Color(0xFFFCAF17);

  static final colorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: darkBlue,
    onPrimary: Colors.white,
    secondary: lightBlue,
    onSecondary: Colors.white,
    error: Colors.red,
    onError: Colors.white,
    background: Colors.white,
    onBackground: darkBlue,
    surface: Colors.white,
    onSurface: darkBlue,
  );
}
