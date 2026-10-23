import 'package:flutter/material.dart';
import '../core/cores.dart';
import '../core/tema.dart';
import '../widgets/fundo_pc_educ.dart';
import '../widgets/texto_contorno.dart';
import "tela_menu.dart";

class TelaTrilhaDetalhe extends StatelessWidget {
  const TelaTrilhaDetalhe({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: FundoPcEduc(
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              _buildCabecalho(context),
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
                                  color: Cores.branco,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: Cores.preto, width: 3),
                                ),
                                child: const Text(
                                  'Bem-vindo ao PC-educ! Bora começar pelo básico do hardware?',
                                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            
                            // SEU MASCOTE (GIF) ESTÁ AQUI
                            Image.asset(
                              'assets/images/pose_8.gif', // <-- Coloque o nome exato do seu arquivo aqui!
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
      
      // NOVA NAVBAR ADICIONADA AQUI
      bottomNavigationBar: _buildBottomNavBar(context),
    );
  }

  Widget _buildCabecalho(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      decoration: const BoxDecoration(
        color: Cores.branco,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
        border: Border(bottom: BorderSide(color: Cores.preto, width: 4)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Cores.preto),
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
          const Text(
            'Conceitos básicos de hardware',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildChip(Icons.local_fire_department, '3 dias'),
              const SizedBox(width: 8),
              _buildChip(Icons.star, '40 XP'),
              const SizedBox(width: 8),
              _buildChip(Icons.check_circle, '0 de 4 níveis'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChip(IconData icone, String texto) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Cores.branco,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Cores.preto, width: 2),
      ),
      child: Row(
        children: [
          Icon(icone, size: 16, color: Cores.preto),
          const SizedBox(width: 4),
          Text(texto, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 11)),
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

  // MÉTODOS DA NAVBAR INFERIOR
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
              // Para navegar de volta ao início ao clicar no ícone "Início"
              GestureDetector(
                onTap: () => Navigator.pop(context), 
                child: _buildNavItem(Icons.home, 'Início', isActive: true),
              ),
              _buildNavItem(Icons.person, 'Perfil'),
              const SizedBox(width: 48), // Espaço para o botão central
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
        // Botão Central Verde
        Positioned(
          top: -24,
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