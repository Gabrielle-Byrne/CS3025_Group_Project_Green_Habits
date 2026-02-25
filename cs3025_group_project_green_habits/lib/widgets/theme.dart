import 'package:flutter/material.dart';

class AppTheme {
  static const Color bg = Color(0xFFFBFFFA);        // app background
  static const Color navBg = Color(0xFFCCDDCF);     // bottom nav background
  static const Color ink = Color(0xFF084E18);       // app bar, text, icons
  static const Color selected = Color(0xFF85A98D);  // selected bottom nav item

  // Dark mode palette
  static const Color darkBg = Color(0xFF0E1410);
  static const Color darkSurface = Color(0xFF121B15);
  static const Color darkNavBg = Color(0xFF16241B);

  // ✅ Super-light mint for dark mode text/icons
  static const Color darkInk = Color(0xFFCFFFE7);

  // Dark mode accents
  static const Color darkSelected = Color(0xFF4F8F61);
  static const Color darkOutline = Color(0xFF2B3A32);

  static const ColorScheme lightScheme = ColorScheme(
    brightness: Brightness.light,

    primary: ink,
    onPrimary: bg,

    secondary: selected,
    onSecondary: bg,

    surface: bg,
    onSurface: ink,

    onSurfaceVariant: ink,

    error: Color(0xFFB3261E),
    onError: Colors.white,

    outline: ink,
    shadow: Colors.black,
    inverseSurface: ink,
    onInverseSurface: bg,
    inversePrimary: selected,
    scrim: Colors.black,

    primaryContainer: bg,
    onPrimaryContainer: ink,
    secondaryContainer: navBg,
    onSecondaryContainer: ink,
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
      navigationBarTheme: NavigationBarThemeData(
        iconTheme: WidgetStatePropertyAll(IconThemeData(color: cs.onSurface)),
        labelTextStyle: WidgetStatePropertyAll(TextStyle(color: cs.onSurface)),
      ),
    );
  }

  static const ColorScheme darkScheme = ColorScheme(
    brightness: Brightness.dark,

    // Keep brand green as primary so HeaderBar stays "Green Habits".
    primary: ink,
    onPrimary: darkInk,

    secondary: darkSelected,
    onSecondary: darkInk,

    surface: darkSurface,
    onSurface: darkInk,
    onSurfaceVariant: darkInk,

    error: Color(0xFFF2B8B5),
    onError: Color(0xFF601410),

    outline: darkOutline,
    shadow: Colors.black,
    inverseSurface: darkInk,
    onInverseSurface: darkBg,
    inversePrimary: darkSelected,
    scrim: Colors.black,

    primaryContainer: darkSurface,
    onPrimaryContainer: darkInk,
    secondaryContainer: darkNavBg,
    onSecondaryContainer: darkInk,
    tertiary: darkSelected,
    onTertiary: darkInk,
    tertiaryContainer: darkNavBg,
    onTertiaryContainer: darkInk,
  );

  static ThemeData dark() {
    final cs = darkScheme;

    return ThemeData(
      useMaterial3: true,
      colorScheme: cs,
      scaffoldBackgroundColor: darkBg,
      iconTheme: const IconThemeData(color: darkInk),
      textTheme: Typography.material2021().white.apply(
        bodyColor: darkInk,
        displayColor: darkInk,
      ),
      // ✅ Ensure AppBar text/icons follow the mint color too
      appBarTheme: const AppBarTheme(
        backgroundColor: ink,
        foregroundColor: darkInk,
        iconTheme: IconThemeData(color: darkInk),
        titleTextStyle: TextStyle(
          color: darkInk,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        elevation: 0,
      ),
      navigationBarTheme: const NavigationBarThemeData(
        backgroundColor: darkNavBg,
        indicatorColor: darkSelected,
        iconTheme: WidgetStatePropertyAll(IconThemeData(color: darkInk)),
        labelTextStyle: WidgetStatePropertyAll(TextStyle(color: darkInk)),
      ),
    );
  }
}
