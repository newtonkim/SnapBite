import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


final TextStyle textFont = GoogleFonts.openSans(
  fontSize: 16,
  color: Colors.white,
);


class AppConstants {
  static const double buttonHeight = 30.0;
  static const double cardBorderRadius = 40.0;
  static const Duration pageTransitionDuration = Duration(milliseconds: 800);
  static const Duration loadingDuration = Duration(seconds: 2);
}
