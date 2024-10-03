// ignore_for_file: unused_import

import 'package:clickchic_app/Onboarding/splash.dart';
import 'package:clickchic_app/Screen/product_page.dart';
import 'package:clickchic_app/theme/dark_theme.dart';
import 'package:clickchic_app/theme/light_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: ProductPage(
        title: 'Custoemr',
      ),
    );
  }
}
