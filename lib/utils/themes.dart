import 'package:flutter/material.dart';

class AppTheme {
  static themedata(bool isDarkTheme) {
    return isDarkTheme ? ThemeColors.darkTheme : ThemeColors.lightTheme;
  }
}

class ThemeColors {
  const ThemeColors._();

  // light theme
  static final lightTheme = ThemeData(
    // scaffold
    scaffoldBackgroundColor: Colors.grey.shade200,
    // appbar
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      titleTextStyle: TextStyle(color: Colors.black),
      elevation: 0,
    ),
    // text
    textTheme: const TextTheme(
      bodySmall: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.black),
    ),
    // tab bar
    tabBarTheme: const TabBarTheme(
      labelColor: Colors.black,
      indicator: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black))),
    ),
    iconTheme: const IconThemeData(color: Colors.black),
  );

  /*
         Dark theme   
   */
  static final darkTheme = ThemeData(
    //scaffold
    scaffoldBackgroundColor: Colors.black,
    // appbar
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      titleTextStyle: TextStyle(color: Colors.white),
      elevation: 0,
    ),
    // text
    textTheme: const TextTheme(
      bodySmall: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
    ),
    // tab bar
    tabBarTheme: const TabBarTheme(
      labelColor: Colors.white,
      indicatorColor: Colors.white,
      indicator: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.yellow))),
    ),
    iconTheme: const IconThemeData(color: Colors.white),
  );
}