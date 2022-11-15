import 'package:flutter/material.dart';

abstract class ColorPalette {
  static const primaryColor = Color(0xff2E22F7);
  static const greys = MaterialColor(
    0xff2B2B2B,
    {
      200: Color(0xff393939),
      500: Color(0xff2B2B2B),
      800: Color(0xff000000),
    },
  );
}
