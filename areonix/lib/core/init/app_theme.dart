import 'package:areonix/core/constants/index.dart';
import 'package:flutter/material.dart';

@immutable
class AppTheme {
  const AppTheme(this.context);

  final BuildContext context;

  ThemeData get theme => ThemeData.light().copyWith(
        primaryColor: TColor.airforce,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: TColor.airforce, // İmleç rengi
          selectionColor:
              TColor.airforce.withOpacity(0.2), // Seçili metnin arka plan rengi
          selectionHandleColor:
              TColor.airforce, // Metin seçimi için handle rengi
        ),
        textTheme: ThemeData.light().textTheme.apply(
              fontFamily: 'Poppins',
            ),
      );
}
