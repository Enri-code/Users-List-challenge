import 'package:flutter/material.dart';
import 'package:owwn_flutter_test/app/theme/colors.dart';
import 'package:owwn_flutter_test/app/theme/widgets_theme.dart';

class DarkThemeProvider {
  late final ThemeData theme;

  DarkThemeProvider(Color primaryColor) {
    final widgetsThemeInfo = WidgetsThemeInfo(primaryColor: primaryColor);

    theme = ThemeData.from(
      colorScheme: ColorScheme.dark(primary: primaryColor),
      textTheme: Typography.whiteCupertino
          .copyWith(bodyMedium: const TextStyle(fontSize: 18))
          .apply(fontFamily: 'Roboto'),
    ).copyWith(
      textButtonTheme: widgetsThemeInfo.textButtonTheme,
      elevatedButtonTheme: widgetsThemeInfo.elevatedButtonTheme,
      outlinedButtonTheme: widgetsThemeInfo.outlinedButtonTheme,
      inputDecorationTheme: widgetsThemeInfo.inputDecorationTheme,
      visualDensity: VisualDensity.compact,
      scaffoldBackgroundColor: ColorPalette.greys[800],
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: true,
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
      ),
    );
  }
}
