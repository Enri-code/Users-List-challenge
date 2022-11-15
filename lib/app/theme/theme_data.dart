import 'package:flutter/material.dart';
import 'package:owwn_flutter_test/app/theme/colors.dart';
import 'package:owwn_flutter_test/app/theme/widgets_theme.dart';

class DarkThemeProvider {
  final WidgetsThemeInfo _buttonTheme;
  late final ThemeData theme;

  DarkThemeProvider(Color primaryColor)
      : _buttonTheme = WidgetsThemeInfo(primaryColor: primaryColor) {
    theme = ThemeData.from(
      colorScheme: ColorScheme.dark(primary: primaryColor),
      textTheme: Typography.whiteCupertino
          .copyWith(bodyMedium: const TextStyle(fontSize: 18))
          .apply(fontFamily: 'Roboto'),
    ).copyWith(
      visualDensity: VisualDensity.compact,
      scaffoldBackgroundColor: ColorPalette.greys[800],
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: true,
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
      ),
      textButtonTheme: _buttonTheme.textButtonTheme,
      elevatedButtonTheme: _buttonTheme.elevatedButtonTheme,
      outlinedButtonTheme: _buttonTheme.outlinedButtonTheme,
      inputDecorationTheme: _buttonTheme.inputDecorationTheme,
    );
  }
}
