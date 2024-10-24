import 'package:chat_in_groups/src/constants/colors.dart';
import 'package:chat_in_groups/src/widgetThemes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class themes {

  themes._();

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: backgroundColor,
    outlinedButtonTheme: lightOutlineButtonData, 
    elevatedButtonTheme: lightElevatedButtonData,
    textTheme: lightTextTheme,
    fontFamily: 'Helvetica',
  );  

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark
  );

}