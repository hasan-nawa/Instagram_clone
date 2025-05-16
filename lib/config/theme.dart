import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  // Common colors
  static const Color primaryColor = Color(0xFF405DE6);
  static const Color secondaryColor = Color(0xFF833AB4);
  static const Color accentColor = Color(0xFFF56040);
  static const Color likeColor = Color(0xFFED4956);
  static const Color indicatorColor = Color(0xFF3797EF);

  // Light theme colors
  static const Color lightBackgroundColor = Color(0xFFFAFAFA);
  static const Color lightTextColor = Colors.black87;
  static const Color lightDividerColor = Color(0xFFDBDBDB);
  static const Color lightIconColor = Colors.black;

  // Dark theme colors
  static const Color darkBackgroundColor = Color(0xFF0e1018);
  static const Color darkTextColor = Colors.white;
  static const Color darkDividerColor = Color(0xFF2A2A2A);
  static const Color darkIconColor = Color(0xFFf9fbfc);
  static const Color darkUnslectedIconColor = Color(0xFFeaeef0);
  static const Color bottomNavigationDarkBgColor = Color(0xFF0e1018);
  static const Color sheetBgColor = Color(0XFF272930);
  static const Color postCommentColor = Color(0XFF4d5ef7);

  static const Color shimmerColor = Color(0xFF181c23);

  // Typography - Light Theme
  static TextStyle lightHeading = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 22.0,
    color: lightTextColor,
  );

  static TextStyle lightSubheading = const TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 16.0,
    color: lightTextColor,
  );

  static TextStyle lightBody = const TextStyle(
    fontSize: 14.0,
    color: lightTextColor,
  );

  static TextStyle lightCaption = const TextStyle(
    fontSize: 12.0,
    color: Colors.black54,
  );

  // Typography - Dark Theme
  static TextStyle darkHeading = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 22.0,
    color: darkTextColor,
  );

  static TextStyle darkSubheading = const TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 16.0,
    color: darkTextColor,
  );

  static TextStyle darkBody = const TextStyle(
    fontSize: 14.0,
    color: darkTextColor,
  );

  static TextStyle darkCaption = const TextStyle(
    fontSize: 12.0,
    color: Colors.white70,
  );

  // Light Theme
  static ThemeData get lightTheme => ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: lightBackgroundColor,
    primaryColor: primaryColor,
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
      background: lightBackgroundColor,
    ),
    appBarTheme: const AppBarTheme(
      elevation: 1,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: lightIconColor),
      titleTextStyle: TextStyle(
        color: lightTextColor,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: lightIconColor,
      unselectedItemColor: Colors.black38,
      backgroundColor: Colors.white,
    ),
    textTheme: TextTheme(
      headlineMedium: lightHeading,
      titleLarge: lightSubheading,
      bodyMedium: lightBody,
      bodySmall: lightCaption,
    ),
    dividerTheme: const DividerThemeData(
      color: lightDividerColor,
      thickness: 0.5,
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style:  OutlinedButton.styleFrom(
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
    iconTheme: const IconThemeData(color: lightIconColor),
  );

  // Dark Theme
  static ThemeData get darkTheme => ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: darkBackgroundColor,
    primaryColor: primaryColor,
    colorScheme: const ColorScheme.dark(
      primary: primaryColor,
      secondary: secondaryColor,
      background: darkBackgroundColor,
    ),

    appBarTheme: const AppBarTheme(
      elevation: 1,
      backgroundColor: bottomNavigationDarkBgColor,
      iconTheme: IconThemeData(color: darkIconColor),
      titleTextStyle: TextStyle(
        color: darkTextColor,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: darkBackgroundColor,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
    ),


    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: darkIconColor,
      unselectedItemColor: darkUnslectedIconColor,
      backgroundColor: bottomNavigationDarkBgColor,
    ),
    textTheme: TextTheme(
      headlineMedium: darkHeading,
      titleLarge: darkSubheading,
      bodyMedium: darkBody,
      bodySmall: darkCaption,
    ),
    dividerTheme: const DividerThemeData(
      color: darkDividerColor,
      thickness: 0.5,
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style:  OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
    iconTheme: const IconThemeData(color: darkIconColor),
  );
}
