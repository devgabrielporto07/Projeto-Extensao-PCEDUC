import 'package:flutter/material.dart';
import '../core/cores.dart';

class BotaoPcEduc extends StatelessWidget {
  const BotaoPcEduc({
    super.key,
    required this.texto,
    required this.aoPressionar,
    this.corFundo = Cores.verdeNeon,
  });

  final String texto;
  final VoidCallback? aoPressionar; // a função que roda quando toca no botão
  final Color corFundo;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: aoPressionar,
        style: ElevatedButton.styleFrom(
          backgroundColor: corFundo,
          foregroundColor: Cores.preto,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(14)),
            side: BorderSide(color: Cores.preto, width: 2),
          ),
        ),
        child: Text(
          texto,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}