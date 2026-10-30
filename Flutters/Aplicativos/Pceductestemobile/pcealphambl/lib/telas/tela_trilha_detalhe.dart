import 'package:flutter/material.dart';
import '../core/cores.dart';
import '../core/tema.dart';
import '../widgets/fundo_pc_educ.dart';
import '../widgets/texto_contorno.dart';
import 'tela_menu.dart';

class TelaTrilhaDetalhe extends StatelessWidget {
  const TelaTrilhaDetalhe({super.key});

  @override
  Widget build(BuildContext context) {
    // Adicionamos o "espião" aqui também! Ele vai atualizar a ecrã 
    // instantaneamente quer mude para escuro ou volte para o claro.
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
                  _buildCabecalho(context, isDark),
                  Expanded(
                    child: Stack(
                      children: [
                        _buildMapaNiveis(),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 90, left: 16, right: 16),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: isDark ? Colors.grey[850] : Cores.branco,
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(color: Cores.preto, width: 3),
                                    ),
                                    child: Text(
                                      'Bem-vindo ao PC-educ! Bora começar pelo básico do hardware?',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700, 
                                        fontSize: 13,
                                        color: isDark ? Colors.white : Cores.preto
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                
                                // O SEU MASCOTE GIF
                                Image.asset(
                                  'assets/images/pose_8.gif',
                                  width: 90,  
                                  height: 110, 
                                  fit: BoxFit.contain,
                                  errorBuilder: (_, _, _) => const Icon(Icons.smart_toy, size: 50, color: Cores.preto),
                                ),
                              ],
                            ),
                          ),
                        ),
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

  Widget _buildCabecalho(BuildContext context, bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[900] : Cores.branco,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
        border: const Border(bottom: BorderSide(color: Cores.preto, width: 4)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back_ios, color: isDark ? Colors.white : Cores.preto),
                onPressed: () => Navigator.pop(context),
              ),
              Expanded(
                child: TextoContorno(
                  'Trilha 1: Introdução',
                  textAlign: TextAlign.center,
                  estilo: Tema.tituloPixel(tamanho: 28, cor: Cores.verdeNeon),
                  larguraContorno: 5,
                ),
              ),
              const SizedBox(width: 48),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Conceitos básicos de hardware',
            style: TextStyle(
              fontWeight: FontWeight.w800, 
              fontSize: 14,
              color: isDark ? Colors.white : Cores.preto
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildChip(Icons.local_fire_department, '3 dias', isDark),
              const SizedBox(width: 8),
              _buildChip(Icons.star, '40 XP', isDark),
              const SizedBox(width: 8),
              _buildChip(Icons.check_circle, '0 de 4 níveis', isDark),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChip(IconData icone, String texto, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[800] : Cores.branco,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Cores.preto, width: 2),
      ),
      child: Row(
        children: [
          Icon(icone, size: 16, color: isDark ? Colors.white : Cores.preto),
          const SizedBox(width: 4),
          Text(texto, style: TextStyle(fontWeight: FontWeight.w800, fontSize: 11, color: isDark ? Colors.white : Cores.preto)),
        ],
      ),
    );
  }

  Widget _buildMapaNiveis() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: SizedBox(
        height: 500,
        child: Stack(
          children: [
            Align(
              alignment: const Alignment(0.0, 0.7),
              child: _buildNo(ativo: true, icone: Icons.play_arrow, texto: 'Nível 1', corFundo: Cores.verdeNeon),
            ),
            Align(
              alignment: const Alignment(0.6, 0.2),
              child: _buildNo(ativo: false, icone: Icons.lock, texto: 'Nível 2'),
            ),
            Align(
              alignment: const Alignment(-0.6, -0.3),
              child: _buildNo(ativo: false, icone: Icons.lock, texto: 'Nível 3'),
            ),
            Align(
              alignment: const Alignment(0.0, -0.8),
              child: _buildNo(ativo: false, icone: Icons.emoji_events, texto: 'Desafio Final', corFundo: const Color(0xFFFFD700)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNo({required bool ativo, required IconData icone, required String texto, Color corFundo = const Color(0xFF94A3B8)}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: corFundo,
            shape: BoxShape.circle,
            border: Border.all(color: Cores.preto, width: 3),
            boxShadow: const [BoxShadow(color: Cores.preto, offset: Offset(0, 4))],
          ),
          child: Icon(icone, size: 36, color: ativo ? Cores.preto : Colors.white70),
        ),
        const SizedBox(height: 8),
        TextoContorno(
          texto,
          estilo: Tema.tituloPixel(tamanho: 16, cor: Cores.branco),
          larguraContorno: 4,
        ),
      ],
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
              GestureDetector(
                onTap: () => Navigator.pop(context), 
                child: _buildNavItem(Icons.home, 'Início', isDark: isDark),
              ),
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
            onTap: () => Navigator.pop(context), 
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