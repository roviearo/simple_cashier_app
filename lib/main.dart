import 'package:flutter/material.dart';
import 'package:simple_cashier_app/core/utils/color_schemes.g.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Simple Cashier Appp',
      theme: ThemeData(
        colorScheme: lightColorScheme,
        useMaterial3: true,
        fontFamily: 'Poppins',
        iconTheme: IconThemeData(
          color: lightColorScheme.primary,
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: darkColorScheme,
        useMaterial3: true,
        fontFamily: 'Poppins',
        iconTheme: IconThemeData(
          color: darkColorScheme.primary,
        ),
      ),
    );
  }
}
