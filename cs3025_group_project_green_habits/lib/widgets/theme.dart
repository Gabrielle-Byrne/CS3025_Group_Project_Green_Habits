import 'package:flutter/material.dart';

class AppTheme {
  static const Color bg = Color(0xFFFBFFFA);        // app background
  static const Color navBg = Color(0xFFCCDDCF);     // bottom nav background
  static const Color ink = Color(0xFF084E18);       // app bar, text, icons
  static const Color selected = Color(0xFF85A98D);  // selected bottom nav item

  static final ColorScheme lightScheme = ColorScheme(
    brightness: Brightness.light,

    primary: ink,
    onPrimary: bg,

    secondary: selected,
    onSecondary: bg,

    surface: bg,
    onSurface: ink,


    onSurfaceVariant: ink,

    error: const Color(0xFFB3261E),
    onError: Colors.white,

    outline: ink,
    shadow: Colors.black,
    inverseSurface: ink,
    onInverseSurface: bg,
    inversePrimary: selected,
    scrim: Colors.black,

    primaryContainer: Colors.green[700],
    onPrimaryContainer: Colors.green[200],
    // primaryContainer: bg,
    // onPrimaryContainer: ink,
    secondaryContainer: Colors.green[700],
    onSecondaryContainer: Colors.green[200],
    // secondaryContainer: navBg,
    // onSecondaryContainer: ink,
    tertiary: selected,
    onTertiary: bg,
    tertiaryContainer: navBg,
    onTertiaryContainer: ink,
  );

  static ThemeData light() {
    final cs = lightScheme;

    return ThemeData(
      useMaterial3: true,
      colorScheme: cs,

      scaffoldBackgroundColor: bg,

      appBarTheme: const AppBarTheme(
        backgroundColor: bg,
        foregroundColor: ink,
        iconTheme: IconThemeData(color: ink),
        titleTextStyle: TextStyle(
          color: bg,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        elevation: 0,
      ),

      iconTheme: const IconThemeData(color: ink),

      textTheme: Typography.material2021().black.apply(
        bodyColor: ink,
        displayColor: ink,
      ),
      /*
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: navBg,
        selectedItemColor: selected,
        unselectedItemColor: ink,
        selectedIconTheme: const IconThemeData(color: selected),
        unselectedIconTheme: const IconThemeData(color: ink),
        type: BottomNavigationBarType.fixed,
      ),*/

      navigationBarTheme: NavigationBarThemeData(
      iconTheme: WidgetStatePropertyAll(IconThemeData(color: cs.onSurface)), // 084E18
      labelTextStyle: WidgetStatePropertyAll(TextStyle(color: cs.onSurface)),
      ),
    );
  }
}