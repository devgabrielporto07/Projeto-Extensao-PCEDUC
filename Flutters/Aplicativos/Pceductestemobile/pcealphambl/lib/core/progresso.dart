// core/progresso.dart
import 'package:flutter/material.dart';
import '../telas/tela_trilha_detalhe.dart';

class Progresso {
  // Simula que o utilizador está na Trilha 1, Nível 1.
  // Quando ele avançar, mudamos estes valores.
  static int trilhaAtual = 1;
  static int nivelAtual = 1;

  static void continuarDeOndeParou(BuildContext context) {
    // Por enquanto, vamos redirecionar sempre para o detalhe da Trilha 1.
    // No futuro, usamos o "trilhaAtual" para saber para qual tela ir.
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const TelaTrilhaDetalhe()), // Vamos criar esta tela abaixo
    );
  }
}