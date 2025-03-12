import 'package:flutter/material.dart';

final theme = ThemeData(
  useMaterial3: true,
);
final darkTheme = ThemeData(
    useMaterial3: true,
    primaryColor: const Color.fromARGB(255, 176, 58, 255),
    scaffoldBackgroundColor: Colors.black,
    colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.white, brightness: Brightness.dark),
    brightness: Brightness.dark);
final lightTheme = ThemeData(
    useMaterial3: true,
    primaryColor: const Color.fromARGB(255, 162, 54, 244),
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.fromSeed(
        seedColor: const Color.fromARGB(255, 162, 54, 244),
        brightness: Brightness.light),
    brightness: Brightness.light);
