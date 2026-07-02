import 'package:flutter/material.dart';

class AppTheme {
  static const Color navy = Color(0xFF071A2D);
  static const Color darkBlue = Color(0xFF0B2545);
  static const Color electricBlue = Color(0xFF1E88FF);
  static const Color cyan = Color(0xFF58D8FF);
  static const Color pearlGray = Color(0xFFE7EDF7);
  static const Color cardDark = Color(0xFF13243A);

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,

      brightness: Brightness.dark,

      scaffoldBackgroundColor: navy,

      primaryColor: electricBlue,

      fontFamily: 'Roboto',

      splashFactory: InkRipple.splashFactory,

      colorScheme: const ColorScheme.dark(
        primary: electricBlue,
        secondary: cyan,
        surface: cardDark,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Colors.white,
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        foregroundColor: Colors.white,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.w900,
        ),
      ),

      cardTheme: CardThemeData(
        color: cardDark,
        elevation: 14,
        shadowColor: Colors.black54,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(26),
        ),
      ),

      iconTheme: const IconThemeData(
        color: Colors.white,
      ),

      textTheme: const TextTheme(
        displayLarge: TextStyle(color: Colors.white),
        displayMedium: TextStyle(color: Colors.white),
        displaySmall: TextStyle(color: Colors.white),

        headlineLarge: TextStyle(color: Colors.white),
        headlineMedium: TextStyle(color: Colors.white),
        headlineSmall: TextStyle(color: Colors.white),

        titleLarge: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),

        titleMedium: TextStyle(
          color: Colors.white,
        ),

        titleSmall: TextStyle(
          color: Colors.white70,
        ),

        bodyLarge: TextStyle(
          color: Colors.white,
        ),

        bodyMedium: TextStyle(
          color: Colors.white,
        ),

        bodySmall: TextStyle(
          color: Colors.white70,
        ),

        labelLarge: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),

        labelMedium: TextStyle(
          color: Colors.white70,
        ),

        labelSmall: TextStyle(
          color: Colors.white54,
        ),
      ),

      dividerColor: Colors.white12,

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white.withOpacity(.06),

        labelStyle: const TextStyle(
          color: Colors.white70,
          fontWeight: FontWeight.w600,
        ),

        hintStyle: const TextStyle(
          color: Colors.white54,
        ),

        prefixIconColor: Colors.white70,
        suffixIconColor: Colors.white70,

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(
            color: Colors.white.withOpacity(.18),
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: electricBlue,
            width: 2,
          ),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: Colors.redAccent,
          ),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: Colors.redAccent,
            width: 2,
          ),
        ),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: electricBlue,
          foregroundColor: Colors.white,
          elevation: 8,
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 18,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 16,
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: cyan,
          textStyle: const TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: electricBlue,
      ),

      listTileTheme: const ListTileThemeData(
        iconColor: Colors.white,
        textColor: Colors.white,
      ),
    );
  }
}