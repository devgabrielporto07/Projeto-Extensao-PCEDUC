import 'package:flutter/material.dart';
import '../core/cores.dart';

class BotaoSocial extends StatelessWidget {
  const BotaoSocial({
    super.key,
    required this.icone,
    required this.aoPressionar,
  });

  final Widget icone;
  final VoidCallback? aoPressionar;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ElevatedButton(
        onPressed: aoPressionar,
        style: ElevatedButton.styleFrom(
          backgroundColor: Cores.branco,
          foregroundColor: Cores.preto,
          padding: EdgeInsets.zero,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            side: BorderSide(color: Cores.preto, width: 2),
          ),
        ),
        child: icone,
      ),
    );
  }
}