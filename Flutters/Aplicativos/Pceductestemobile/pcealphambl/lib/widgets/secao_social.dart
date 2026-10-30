import 'package:flutter/material.dart';
import '../core/cores.dart';
import 'botao_social.dart';

class SecaoSocial extends StatelessWidget {
  const SecaoSocial({
    super.key, 
    required this.textoDivisor,
    this.aoPressionarApple, // <- Novo parâmetro para o nosso atalho
  });
  
  final String textoDivisor;
  final VoidCallback? aoPressionarApple;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            const Expanded(child: Divider(color: Cores.preto)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                textoDivisor,
                style: const TextStyle(color: Cores.preto, fontSize: 13),
              ),
            ),
            const Expanded(child: Divider(color: Cores.preto)),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: BotaoSocial(
                icone: const Icon(Icons.g_mobiledata, size: 34),
                aoPressionar: () {},
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: BotaoSocial(
                icone: const Icon(Icons.apple, size: 26),
                aoPressionar: aoPressionarApple, // <- Ação ligada ao botão da maçã
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: BotaoSocial(
                icone: const Icon(Icons.forum, size: 24),
                aoPressionar: () {},
              ),
            ),
          ],
        ),
      ],
    );
  }
}