import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

OutlinedButtonThemeData lightOutlineButtonData = OutlinedButtonThemeData(
  style: ButtonStyle(
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      )
    ),
    padding: const WidgetStatePropertyAll(EdgeInsetsDirectional.symmetric(vertical: 10.0))
  )
);

TextTheme lightTextTheme = TextTheme(
  displayLarge: GoogleFonts.ptSerif(fontWeight: FontWeight.w600, fontSize: 18),
  headlineMedium: GoogleFonts.ptSerif(fontWeight: FontWeight.w500, fontSize: 15),
  labelLarge: GoogleFonts.ptSerif(fontWeight: FontWeight.w700, fontSize: 16),
  labelMedium: GoogleFonts.ptSerif(fontSize: 14, fontWeight: FontWeight.w700),
  labelSmall: GoogleFonts.ptSerif(fontWeight: FontWeight.w400, fontSize: 12),
  bodyMedium: GoogleFonts.lato(),
  headlineLarge: GoogleFonts.ptSerif(fontWeight: FontWeight.w900, fontSize: 24),
  headlineSmall: GoogleFonts.ptSerif(fontSize: 12),
  titleLarge: GoogleFonts.ptSerif(fontWeight: FontWeight.w600, fontSize: 18, color: Colors.white),
  titleMedium: GoogleFonts.ptSerif(fontWeight: FontWeight.w500, fontSize: 15, color: Colors.white),
  titleSmall: GoogleFonts.ptSerif(fontWeight: FontWeight.w500, fontSize: 12, color: Colors.white),
);

ElevatedButtonThemeData lightElevatedButtonData =  ElevatedButtonThemeData(
  style: ButtonStyle(
    textStyle:  WidgetStatePropertyAll(GoogleFonts.ptSerif(fontWeight: FontWeight.w500, fontSize: 15, color: Colors.white)),
    backgroundColor: const WidgetStatePropertyAll(Color.fromARGB(255, 9, 9, 26)),
    padding: const WidgetStatePropertyAll(EdgeInsetsDirectional.symmetric(vertical: 18.0)),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      )
    ),
  )
);