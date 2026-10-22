import 'package:flutter/material.dart';
import '../core/cores.dart';
import 'botao_social.dart';

class SecaoSocial extends StatelessWidget {
  const SecaoSocial({super.key, required this.textoDivisor});

  final String textoDivisor;

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
                aoPressionar: () {},
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