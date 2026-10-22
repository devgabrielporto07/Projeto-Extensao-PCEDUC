import 'package:flutter/material.dart';
import '../core/cores.dart';

class FundoPcEduc extends StatelessWidget {
  const FundoPcEduc({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const ColoredBox(color: Cores.azulFundo),
        Image.asset(
          'assets/images/fundo_rolagem.gif',
          fit: BoxFit.cover,
          errorBuilder: (_, _, _) => const SizedBox.shrink(),
        ),
        child,
      ],
    );
  }
}