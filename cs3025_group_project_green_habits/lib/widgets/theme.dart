import 'package:flutter/material.dart';

/// Single source of truth for all colors + component styling.
///
/// Team rule of thumb:
/// - Raw hex colors should appear ONLY in this file.
/// - Everywhere else: read colors from Theme.of(context).colorScheme (or context.cs).
class AppTheme {
  /* ---------- Light palette (matches mockups) ---------- */

  /// Brand / header green
  static const Color brand = Color(0xFF084E18);

  /// Slightly brighter green (used for "Need Tips?" button / accents)
  static const Color accent = Color(0xFF1E6B2A);

  /// App background
  static const Color bg = Color(0xFFFBFFFA);

  /// Bottom nav background (slightly darker than panels)
  static const Color navBg = Color(0xFFCCDDCF);

  /// Card/panel fill
  static const Color panelBg = Color(0xFFD6E4D6);

  /// Panel borders / subtle dividers
  static const Color panelBorder = Color(0xFFB8C8B8);

  /// Selected highlight (nav indicator, pills)
  static const Color selected = Color(0xFF7CA384);

  /* ---------- Dark palette (tunable later) ---------- */

  static const Color darkBg = Color(0xFF0E1410);
  static const Color darkSurface = Color(0xFF121B15);
  static const Color darkNavBg = Color(0xFF16241B);

  /// Super-light mint for dark mode text/icons
  static const Color darkInk = Color(0xFFCFFFE7);

  static const Color darkSelected = Color(0xFF4F8F61);
  static const Color darkOutline = Color(0xFF2B3A32);

  /* ---------- Color schemes ---------- */

  static const ColorScheme lightScheme = ColorScheme(
    brightness: Brightness.light,
    primary: brand,
    onPrimary: Colors.white,
    primaryContainer: panelBg,
    onPrimaryContainer: brand,

    secondary: selected,
    onSecondary: brand,
    secondaryContainer: navBg,
    onSecondaryContainer: brand,

    tertiary: accent,
    onTertiary: Colors.white,
    tertiaryContainer: panelBg,
    onTertiaryContainer: brand,

    error: Color(0xFFB3261E),
    onError: Colors.white,

    surface: bg,
    onSurface: brand,
    surfaceVariant: panelBg,
    onSurfaceVariant: brand,

    outline: panelBorder,
    outlineVariant: panelBorder,

    shadow: Colors.black,
    scrim: Colors.black,

    inverseSurface: brand,
    onInverseSurface: bg,
    inversePrimary: selected,
  );

  static const ColorScheme darkScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: brand,
    onPrimary: darkInk,
    primaryContainer: darkSurface,
    onPrimaryContainer: darkInk,

    secondary: darkSelected,
    onSecondary: darkInk,
    secondaryContainer: darkNavBg,
    onSecondaryContainer: darkInk,

    tertiary: darkSelected,
    onTertiary: darkInk,
    tertiaryContainer: darkSurface,
    onTertiaryContainer: darkInk,

    error: Color(0xFFF2B8B5),
    onError: Color(0xFF601410),

    surface: darkBg,
    onSurface: darkInk,
    surfaceVariant: darkSurface,
    onSurfaceVariant: darkInk,

    outline: darkOutline,
    outlineVariant: darkOutline,

    shadow: Colors.black,
    scrim: Colors.black,

    inverseSurface: darkInk,
    onInverseSurface: darkBg,
    inversePrimary: darkSelected,
  );

  static ThemeData light() => _themeFrom(lightScheme);
  static ThemeData dark() => _themeFrom(darkScheme);

  static ThemeData _themeFrom(ColorScheme cs) {
    final isDark = cs.brightness == Brightness.dark;

    final baseText = isDark
        ? Typography.material2021().white
        : Typography.material2021().black;

    return ThemeData(
      useMaterial3: true,
      colorScheme: cs,
      scaffoldBackgroundColor: cs.surface,

      textTheme: baseText.apply(
        bodyColor: cs.onSurface,
        displayColor: cs.onSurface,
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: cs.primary,
        foregroundColor: cs.onPrimary,
        elevation: 0,
        iconTheme: IconThemeData(color: cs.onPrimary),
        titleTextStyle: TextStyle(
          color: cs.onPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.6,
        ),
      ),

      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: cs.secondaryContainer,
        indicatorColor: cs.secondary.withOpacity(isDark ? 0.35 : 0.55),
        indicatorShape: const StadiumBorder(),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(color: cs.onSecondary);
          }
          return IconThemeData(color: cs.onSecondaryContainer);
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final color = states.contains(WidgetState.selected)
              ? cs.onSecondary
              : cs.onSecondaryContainer;
          return TextStyle(
            color: color,
            fontWeight: FontWeight.w700,
            fontSize: 12,
          );
        }),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: cs.primary,
          foregroundColor: cs.onPrimary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: cs.primary,
          textStyle: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: cs.surfaceVariant,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: cs.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: cs.primary, width: 1.5),
        ),
        labelStyle: TextStyle(color: cs.onSurfaceVariant),
        hintStyle: TextStyle(color: cs.onSurfaceVariant.withOpacity(0.7)),
      ),

      toggleButtonsTheme: ToggleButtonsThemeData(
        borderRadius: BorderRadius.circular(10),
        selectedColor: cs.onPrimaryContainer,
        fillColor: cs.primaryContainer,
        color: cs.onSurfaceVariant,
        selectedBorderColor: cs.primary,
        borderColor: cs.outlineVariant,
      ),

      snackBarTheme: SnackBarThemeData(
        backgroundColor: cs.inverseSurface,
        contentTextStyle: TextStyle(color: cs.onInverseSurface),
      ),

      dividerTheme: DividerThemeData(
        color: cs.outlineVariant.withOpacity(0.6),
      ),
    );
  }
}

/// Tiny convenience so widgets can do `context.cs.primary`.
extension ThemeX on BuildContext {
  ColorScheme get cs => Theme.of(this).colorScheme;
  bool get isDark => Theme.of(this).brightness == Brightness.dark;
}
