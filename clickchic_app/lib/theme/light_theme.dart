import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    primary: Colors.black,
    secondary: Colors.green,
    background: Colors.white,
    onPrimary: Color.fromARGB(255, 255, 255, 255),
    onSecondary: Colors.black,
    onBackground: Color.fromARGB(255, 0, 106, 255),
    surface: Color.fromARGB(255, 1, 19, 3),
    onSurface: Color.fromARGB(255, 1, 19, 3),
    surfaceVariant: Color.fromARGB(255, 255, 255, 255),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.black),
  ),
  navigationBarTheme: NavigationBarThemeData(
    indicatorColor: Colors.green,
    backgroundColor: Colors.transparent,
    iconTheme: MaterialStateProperty.all(IconThemeData(color: Colors.black)),
    labelTextStyle: MaterialStateProperty.all(TextStyle(color: Colors.black)),
  ),

  // ignore: deprecated_member_use
  bottomAppBarColor: Color(0xFFCBD3BA),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Colors.green),
    ),
  ),
);
