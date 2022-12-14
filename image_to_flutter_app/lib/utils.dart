import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle textStyle(
        [double size = 16,
        Color color = Colors.white,
        FontWeight fw = FontWeight.bold]) =>
    GoogleFonts.montserrat(fontSize: size, color: color, fontWeight: fw);
