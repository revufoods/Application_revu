import 'package:flutter/material.dart';

const Color colorPrimary = Color(0XFF14beaf);
const Color colorSecondary = Color(0xffffa500);

class AppTheme {
  ThemeData theme() {
    return ThemeData(
        useMaterial3: true,
        inputDecorationTheme: const InputDecorationTheme(
          floatingLabelStyle: TextStyle(color: Colors.grey),
          labelStyle: TextStyle(color: Colors.grey),
          hintStyle: TextStyle(color: Colors.grey),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
        ));
  }
}
