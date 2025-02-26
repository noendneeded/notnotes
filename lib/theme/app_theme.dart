import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

abstract class AppTheme {
  static final theme = FlexThemeData.light(
    ///
    useMaterial3: true,

    // textTheme: GoogleFonts.openSansTextTheme(),

    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    appBarStyle: FlexAppBarStyle.material,

    appBarElevation: 0,
    bottomAppBarElevation: 0,

    scheme: FlexScheme.blackWhite,
    primary: Colors.black,
    surface: Colors.grey,
    scaffoldBackground: Colors.white,
    dialogBackground: Colors.white,
    appBarBackground: Colors.white,
  );
}
