import 'package:flutter/material.dart';
import '../core/cores.dart';
import '../widgets/botao_pc_educ.dart';
import '../widgets/fundo_pc_educ.dart';
import 'tela_cadastro.dart';
import 'tela_login.dart';
import '../widgets/texto_contorno.dart';

class TelaBoasVindas extends StatelessWidget {
  const TelaBoasVindas({super.key});

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
                                height: tamanho.height * 0.2,
                                errorBuilder: (_, _, _) => const Icon(
                                  Icons.memory,
                                  size: 100,
                                  color: Cores.branco,
                                ),
                              ),
                              const SizedBox(height: 12),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: TextoContorno(
                        'Bora entender o que tem dentro do computador!',
                        textAlign: TextAlign.center,
                        larguraContorno: 6,
                        estilo: const TextStyle(
                          color: Cores.branco,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    BotaoPcEduc(
                      texto: 'Criar conta',
                      aoPressionar: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const TelaCadastro()),
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    BotaoPcEduc(
                      texto: 'Entrar',
                      corFundo: Cores.branco,
                      aoPressionar: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const TelaLogin()),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
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