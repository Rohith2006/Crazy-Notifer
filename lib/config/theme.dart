import 'package:flutter/material.dart';

final appTheme = ThemeData(
  primarySwatch: Colors.purple,
  hintColor: Colors.orangeAccent,
  fontFamily: 'Roboto',
  textTheme: TextTheme(
    displayLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
    titleLarge: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
    bodyMedium: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
  ),
  buttonTheme: ButtonThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
    buttonColor: Colors.purpleAccent,
  ),
);