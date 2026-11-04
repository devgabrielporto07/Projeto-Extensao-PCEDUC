import 'package:flutter/material.dart';
import '../core/cores.dart';

class TextoContorno extends StatelessWidget {
  const TextoContorno(
    this.texto, {
    super.key,
    required this.estilo,
    this.corContorno = Cores.preto,
    this.larguraContorno = 4,
    this.textAlign,
  });

  final String texto;
  final TextStyle estilo;
  final Color corContorno;
  final double larguraContorno;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          texto,
          textAlign: textAlign,
          style: estilo.copyWith(
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = larguraContorno
              ..strokeJoin = StrokeJoin.round
              ..color = corContorno,
          ),
        ),
        Text(texto, textAlign: textAlign, style: estilo),
      ],
    );
  }
}