import 'package:flutter/material.dart';

class ColorSchemes {


static final ColorScheme lightMode = ColorScheme.fromSeed(
          seedColor:const Color(0xFF084E18),
          brightness: Brightness.light, 
        );

static final ColorScheme darkMode = ColorScheme.fromSeed(
          seedColor: const Color(0xFFCADCCD),
          brightness: Brightness.dark, 
        );

  // static const ColorScheme lightMode = ColorScheme(
  //   brightness: Brightness.light, 
  //   primary: Color.fromARGB(255, 255, 255, 255),
  //   onPrimary: Color(0xFF084E18), 
  //   secondary: Color(0xFF084E18), 
  //   onSecondary: Color.fromARGB(255, 179, 255, 135), 
  //   error: Color.fromARGB(255, 255, 191, 191), 
  //   onError: Color.fromARGB(255, 179, 18, 18), 
  //   surface: Color.fromARGB(255, 104, 183, 58), 
  //   onSurface: Color.fromARGB(255, 104, 183, 58)
  // );

  //  static const ColorScheme darkMode = ColorScheme(
  //   brightness: Brightness.dark, 
  //   primary: Color.fromARGB(255, 255, 255, 255),
  //   onPrimary: Color.fromARGB(255, 21, 55, 1), 
  //   secondary: Color.fromARGB(255, 21, 214, 7), 
  //   onSecondary: Color.fromARGB(255, 179, 255, 135), 
  //   error: Color.fromARGB(255, 255, 191, 191), 
  //   onError: Color.fromARGB(255, 179, 18, 18), 
  //   surface: Color.fromARGB(255, 104, 183, 58), 
  //   onSurface: Color.fromARGB(255, 104, 183, 58)
  // );

  static ThemeData lightTheme = ThemeData(
    colorScheme: lightMode,
    useMaterial3: true,
    scaffoldBackgroundColor: lightMode.inversePrimary,
    appBarTheme: AppBarTheme(
      backgroundColor: lightMode.primary,
      foregroundColor: lightMode.onPrimary,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    colorScheme: darkMode,
    useMaterial3: true,
    scaffoldBackgroundColor: darkMode.inversePrimary,
    appBarTheme: AppBarTheme(
      backgroundColor: darkMode.primary,
      foregroundColor: darkMode.onPrimary,
    ),
  );
}