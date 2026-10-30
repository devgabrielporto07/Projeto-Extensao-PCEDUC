import 'package:flutter/material.dart';
import '../core/cores.dart';

class BotaoVoltar extends StatelessWidget {
  const BotaoVoltar({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Cores.branco,
      shape: const CircleBorder(side: BorderSide(color: Cores.preto, width: 2)),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: () => Navigator.pop(context),
        child: const Padding(
          padding: EdgeInsets.all(8),
          child: Icon(Icons.arrow_back, color: Cores.preto),
        ),
      ),
    );
  }
}