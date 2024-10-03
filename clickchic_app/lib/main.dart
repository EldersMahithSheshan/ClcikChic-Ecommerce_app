// ignore_for_file: unused_import

import 'package:clickchic_app/Onboarding/splash.dart';
import 'package:clickchic_app/Screen/product_page.dart';
import 'package:clickchic_app/Services/cart_provider.dart';
import 'package:clickchic_app/theme/dark_theme.dart';
import 'package:clickchic_app/theme/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

void main() {
  assert(() {
    debugPaintSizeEnabled = false; // Disable the debug outline in debug mode
    return true;
  }());
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => CartProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: splash(),
    );
  }
}
