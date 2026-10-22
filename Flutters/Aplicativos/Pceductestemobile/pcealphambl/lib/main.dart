import 'package:flutter/material.dart';
import 'core/cores.dart';
import 'telas/tela_abertura.dart';
void main() => runApp(const PcEducApp());

class PcEducApp extends StatelessWidget {
  const PcEducApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PC educ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Cores.azulFundo),
      home: const TelaAbertura(),
    );
  }
}

class TelaTeste extends StatelessWidget {
  const TelaTeste({super.key});

  @override
  Widget build(BuildContext context) {
    final tamanho = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: Cores.azulFundo,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Tela: ${tamanho.width.toStringAsFixed(0)} x '
                    '${tamanho.height.toStringAsFixed(0)} dp',
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Cores.verdeNeon,
                        foregroundColor: Cores.preto,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: const BorderSide(color: Cores.preto, width: 2),
                        ),
                      ),
                      child: const Text('Criar sua conta'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}