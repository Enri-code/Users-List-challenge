import 'package:flutter/material.dart';
import 'package:owwn_flutter_test/app/theme/colors.dart';

class WidgetsThemeInfo {
  final TextButtonThemeData textButtonTheme;
  final OutlinedButtonThemeData outlinedButtonTheme;

  WidgetsThemeInfo({required Color primaryColor})
      : textButtonTheme = TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: primaryColor),
        ),
        outlinedButtonTheme = OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            fixedSize: const Size(380, 56),
            padding: const EdgeInsets.all(12),
            side: BorderSide(width: 1.5, color: primaryColor),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );

  final elevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      fixedSize: const Size(380, 56),
      foregroundColor: Colors.white,
      textStyle: const TextStyle(fontSize: 18),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  );

  final inputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: ColorPalette.greys[200],
    hintStyle: const TextStyle(color: Colors.grey, height: 1.2),
    errorStyle:
        const TextStyle(fontSize: 14, color: Color.fromARGB(255, 241, 0, 0)),
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
    ),
    enabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(color: Color(0xFFD9D9D9)),
    ),
    contentPadding: const EdgeInsets.all(24),
  );
}
