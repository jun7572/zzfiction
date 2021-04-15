 import 'package:flutter/material.dart';

class ThemeUtil{
  static ThemeData getlitghTheme(){
    return ThemeData(
      primaryColor: Colors.grey[200],

      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
 }