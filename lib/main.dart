import 'package:flutter/material.dart';
import 'package:patient_list/assets/theme_assets.dart';
import 'package:patient_list/pages/splash_page.dart';

void main() {
  final selectedColor = ThemeAssets.teal;

  runApp(
    MaterialApp(
      title: 'Patient List',
      home: const SplashPage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: selectedColor,
        splashColor: selectedColor.withOpacity(0.2),
      ),
    ),
  );
}
