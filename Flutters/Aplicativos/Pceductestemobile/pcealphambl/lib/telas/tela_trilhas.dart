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
    // 1. O ValueListenableBuilder fica a "ouvir" a mudança de tema em tempo real
    return ValueListenableBuilder<bool>(
      valueListenable: Tema.modoEscuro,
      builder: (context, isDark, _) {
        
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
                        _buildTrilhaBloqueada('Trilha 2: Por dentro do PC', 'Conclua a Trilha 1 para liberar', isDark),
                        const SizedBox(height: 16),
                        _buildTrilhaBloqueada('Trilha 3: Montando um PC', 'Conclua a Trilha 2 para liberar', isDark),
                        const SizedBox(height: 16),
                        _buildTrilhaBloqueada('Trilha 4: Redes e internet', 'Conclua a Trilha 3 para liberar', isDark),
                        const SizedBox(height: 16),
                        _buildTrilhaBloqueada('Trilha 5: Programação básica', 'Conclua a Trilha 4 para liberar', isDark),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: _buildBottomNavBar(context, isDark),
        );
      },
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
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Cores.preto),
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
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Cores.preto),
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
                      style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12, color: Cores.preto),
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

  Widget _buildTrilhaBloqueada(String titulo, String subtitulo, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0),
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
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: isDark ? Colors.white : Cores.preto),
                ),
                Text(
                  subtitulo,
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: isDark ? Colors.white70 : const Color(0xFF64748B)),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF334155) : Cores.branco,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Cores.preto, width: 2),
            ),
            child: Icon(Icons.lock, color: isDark ? Colors.white : Cores.preto),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar(BuildContext context, bool isDark) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: 70,
          decoration: BoxDecoration(
            color: isDark ? Colors.grey[900] : Cores.branco,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            border: const Border(top: BorderSide(color: Cores.preto, width: 3)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home, 'Início', isActive: true, isDark: isDark),
              _buildNavItem(Icons.person, 'Perfil', isDark: isDark),
              const SizedBox(width: 48),
              _buildNavItem(Icons.star, 'Conquistas', isDark: isDark),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const TelaMenu()));
                },
                child: _buildNavItem(Icons.menu, 'Menu', isDark: isDark),
              ),
            ],
          ),
        ),
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

  Widget _buildNavItem(IconData icone, String texto, {bool isActive = false, required bool isDark}) {
    final corInativo = isDark ? Colors.white54 : const Color(0xFF94A3B8);
    final cor = isActive ? Cores.verdeNeon : corInativo;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: isActive ? const EdgeInsets.all(4) : EdgeInsets.zero,
          decoration: isActive ? BoxDecoration(color: Cores.verdeNeon, borderRadius: BorderRadius.circular(8), border: Border.all(color: Cores.preto, width: 2)) : null,
          child: Icon(icone, color: isActive ? Cores.preto : cor, size: isActive ? 24 : 28),
        ),
        if (!isActive)
          Text(
            texto,
            style: TextStyle(color: cor, fontSize: 10, fontWeight: FontWeight.w600),
          ),
      ],
    );
  }
}