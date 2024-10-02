// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: Colors.black,
    primary: Colors.white,
    secondary: Colors.green,
    onPrimary: Color.fromARGB(255, 0, 0, 0),
    onSecondary: Colors.black,
    onBackground: Color(0xFF1D3557),
    surface: const Color.fromARGB(255, 55, 54, 54),
    onSurface: Colors.white,
    surfaceVariant: const Color.fromARGB(255, 55, 54, 54),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.black,
    iconTheme: IconThemeData(color: Colors.white),
  ),
  navigationBarTheme: NavigationBarThemeData(
    indicatorColor: Colors.green,
    backgroundColor: Color.fromARGB(255, 217, 0, 0),
    iconTheme: MaterialStateProperty.all(IconThemeData(color: Colors.white)),
    labelTextStyle: MaterialStateProperty.all(TextStyle(color: Colors.white)),
  ),
  bottomAppBarColor: Color.fromARGB(255, 0, 0, 0),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Colors.green),
    ),
  ),
);
