import 'package:flutter/material.dart';
import '../core/cores.dart';
import '../core/tema.dart';
import '../widgets/fundo_pc_educ.dart';
import '../widgets/texto_contorno.dart';
import '../core/progresso.dart';
import 'tela_trilha_detalhe.dart';
import 'tela_menu.dart';

class TelaTrilhas extends StatelessWidget {
  const TelaTrilhas({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: FundoPcEduc(
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              const SizedBox(height: 20),
              TextoContorno(
                'Trilhas',
                estilo: Tema.tituloPixel(tamanho: 48, cor: Cores.verdeNeon),
                larguraContorno: 8,
              ),
              const SizedBox(height: 4),
              TextoContorno(
                'Escolha seu caminho do conhecimento',
                estilo: Tema.tituloPixel(tamanho: 16, cor: Cores.branco),
                larguraContorno: 4,
              ),
              const SizedBox(height: 24),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  physics: const BouncingScrollPhysics(),
                  children: [
                    _buildTrilhaAtiva(context),
                    const SizedBox(height: 16),
                    _buildTrilhaBloqueada('Trilha 2: Por dentro do PC', 'Conclua a Trilha 1 para liberar'),
                    const SizedBox(height: 16),
                    _buildTrilhaBloqueada('Trilha 3: Montando um PC', 'Conclua a Trilha 2 para liberar'),
                    const SizedBox(height: 16),
                    _buildTrilhaBloqueada('Trilha 4: Redes e internet', 'Conclua a Trilha 3 para liberar'),
                    const SizedBox(height: 16),
                    _buildTrilhaBloqueada('Trilha 5: Programação básica', 'Conclua a Trilha 4 para liberar'),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(context),
    );
  }

  Widget _buildTrilhaAtiva(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Cores.verdeNeon,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Cores.preto, width: 3),
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Botão Jogar (Azul) com Clique
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const TelaTrilhaDetalhe()),
                  );
                },
                child: Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1B3B86),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Cores.preto, width: 2),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.play_arrow, color: Cores.verdeNeon, size: 36),
                      Text(
                        'Jogar',
                        style: TextStyle(color: Cores.branco, fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Cores.branco,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Cores.preto, width: 2),
                      ),
                      child: const Text(
                        'Nível 1 de 4',
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800),
                      ),
                    ),
                    const SizedBox(height: 4),
                    TextoContorno(
                      'Trilha 1: Introdução',
                      estilo: Tema.tituloPixel(tamanho: 20, cor: Cores.branco),
                      larguraContorno: 4,
                    ),
                    const Text(
                      'Conceitos básicos de hardware e software',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Cores.preto),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 32,
                  decoration: BoxDecoration(
                    color: Cores.branco,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Cores.preto, width: 2),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 4),
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Cores.verdeNeon,
                          shape: BoxShape.circle,
                          border: Border.all(color: Cores.preto, width: 2),
                        ),
                      ),
                      const Expanded(
                        child: Center(
                          child: Text(
                            '15% concluído',
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                height: 32,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFD700),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Cores.preto, width: 2),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.emoji_events, size: 16, color: Cores.preto),
                    SizedBox(width: 4),
                    Text(
                      'Estudar',
                      style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTrilhaBloqueada(String titulo, String subtitulo) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: const Color(0xFFE2E8F0),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Cores.preto, width: 3),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Cores.preto),
                ),
                Text(
                  subtitulo,
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF64748B)),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Cores.branco,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Cores.preto, width: 2),
            ),
            child: const Icon(Icons.lock, color: Cores.preto),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: 70,
          decoration: const BoxDecoration(
            color: Cores.branco,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            border: Border(top: BorderSide(color: Cores.preto, width: 3)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home, 'Início', isActive: true),
              _buildNavItem(Icons.person, 'Perfil'),
              const SizedBox(width: 48),
              _buildNavItem(Icons.star, 'Conquistas'),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const TelaMenu()));
                },
                child: _buildNavItem(Icons.menu, 'Menu'),
              ),
            ],
          ),
        ),
        // Botão Central Verde com Clique
        Positioned(
          top: -24,
          child: GestureDetector(
            onTap: () => Progresso.continuarDeOndeParou(context),
            child: Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: Cores.verdeNeon,
                shape: BoxShape.circle,
                border: Border.all(color: Cores.preto, width: 4),
                boxShadow: const [BoxShadow(color: Cores.preto, offset: Offset(0, 4))],
              ),
              child: const Icon(Icons.play_arrow, color: Cores.preto, size: 40),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNavItem(IconData icone, String texto, {bool isActive = false}) {
    final cor = isActive ? Cores.verdeNeon : const Color(0xFF94A3B8);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icone, color: isActive ? Cores.preto : cor, size: 28),
        Text(
          texto,
          style: TextStyle(
            color: isActive ? Cores.preto : cor,
            fontSize: 10,
            fontWeight: isActive ? FontWeight.bold : FontWeight.w600,
          ),
        ),
      ],
    );
  }
}