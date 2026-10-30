import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'cores.dart';

class Tema {
  static final ValueNotifier<bool> modoEscuro = ValueNotifier(false);

  static ThemeData get tema {
    final base = ThemeData(useMaterial3: true, colorSchemeSeed: Cores.azulFundo);
    return base.copyWith(
      textTheme: GoogleFonts.nunitoTextTheme(base.textTheme),
    );
  }

  static TextStyle tituloPixel({double tamanho = 32, Color cor = Cores.verdeNeon}) {
    return GoogleFonts.pixelifySans(
      fontSize: tamanho,
      fontWeight: FontWeight.w700,
      color: cor,
    );
  }
}