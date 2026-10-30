import 'dart:async';

import 'package:flutter/material.dart';
import '../core/cores.dart';
import '../widgets/fundo_pc_educ.dart';
import 'tela_boas_vindas.dart';

class TelaAbertura extends StatefulWidget {
  const TelaAbertura({super.key});

  @override
  State<TelaAbertura> createState() => _TelaAberturaState();
}

class _TelaAberturaState extends State<TelaAbertura> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Depois de 3 segundos, vai sozinho para a tela de boas-vindas
    _timer = Timer(const Duration(seconds: 3), _irParaBoasVindas);
  }

  @override
  void dispose() {
    _timer?.cancel(); // evita que o relógio dispare depois que a tela saiu
    super.dispose();
  }

  void _irParaBoasVindas() {
    _timer?.cancel(); 
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const TelaBoasVindas()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tamanho = MediaQuery.sizeOf(context);

    return Scaffold(
      body: FundoPcEduc(
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                'assets/images/logopc.png',
                                height: tamanho.height * 0.4,
                                errorBuilder: (_, _, _) => const Icon(
                                  Icons.memory,
                                  size: 120,
                                  color: Cores.branco,
                                ),
                              ),
                              const SizedBox(height: 16),
                            ],
                          ),
                        ),
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: 0.8,
                      child: ElevatedButton(
                        onPressed: _irParaBoasVindas, // também funciona como "pular"
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Cores.branco,
                          foregroundColor: Cores.preto,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: const StadiumBorder(
                            side: BorderSide(color: Cores.preto, width: 2),
                          ),
                        ),
                        child: const Text(
                          'Aprenda hardware jogando',
                          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}