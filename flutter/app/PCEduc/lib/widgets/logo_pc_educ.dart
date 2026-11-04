import 'package:flutter/material.dart';
import '../core/cores.dart';
import '../core/tema.dart';
import 'texto_contorno.dart';

class LogoPcEduc extends StatelessWidget {
  const LogoPcEduc({super.key, this.tamanho = 72});
  final double tamanho;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextoContorno(
          'PC',
          estilo: Tema.tituloPixel(tamanho: tamanho, cor: Cores.branco),
          larguraContorno: tamanho * 0.12,
        ),
        TextoContorno(
          'educ!',
          estilo: Tema.tituloPixel(tamanho: tamanho * 0.4, cor: Cores.verdeNeon),
          larguraContorno: tamanho * 0.06,
        ),
      ],
    );
  }
}