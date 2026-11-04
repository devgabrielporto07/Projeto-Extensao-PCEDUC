import 'package:flutter/material.dart';
import '../core/cores.dart';
import '../core/tema.dart';
import '../widgets/fundo_pc_educ.dart';
import '../widgets/texto_contorno.dart';
import 'tela_menu.dart';
import 'tela_conquistas.dart';

class TelaPerfil extends StatelessWidget {
  const TelaPerfil({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: Tema.modoEscuro,
      builder: (context, isDark, _) {
        final corTexto = isDark ? Colors.white : Cores.preto;
        final corCartao = isDark ? const Color(0xFF1E293B) : Cores.branco;

        return Scaffold(
          extendBody: true,
          body: FundoPcEduc(
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  TextoContorno(
                    'Perfil',
                    estilo: Tema.tituloPixel(tamanho: 48, cor: Cores.verdeNeon),
                    larguraContorno: 8,
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF0F172A) : const Color(0xFFE2E8F0),
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                        border: const Border(top: BorderSide(color: Cores.preto, width: 3)),
                      ),
                      child: ListView(
                        padding: const EdgeInsets.all(20),
                        physics: const BouncingScrollPhysics(),
                        children: [
                          Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: corCartao,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Cores.preto, width: 3),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: Cores.azulFundo,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Cores.preto, width: 3),
                                  ),
                                  child: const Icon(Icons.person, size: 50, color: Cores.branco),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'Aluno Hardware', // Nome provisório
                                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: corTexto),
                                ),
                                Text(
                                  'aluno@email.com', // E-mail provisório
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: isDark ? Colors.white70 : Colors.grey[700]),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: _buildEstatistica('XP Total', '120', Icons.star, const Color(0xFFFFD700), isDark),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _buildEstatistica('Ofensiva', '3 dias', Icons.local_fire_department, Colors.orange, isDark),
                              ),
                            ],
                          ),
                          const SizedBox(height: 100), // Espaço para a navbar
                        ],
                      ),
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

  Widget _buildEstatistica(String titulo, String valor, IconData icone, Color corIcone, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Cores.branco,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Cores.preto, width: 3),
        boxShadow: const [BoxShadow(color: Cores.preto, offset: Offset(0, 4))],
      ),
      child: Column(
        children: [
          Icon(icone, size: 40, color: corIcone),
          const SizedBox(height: 8),
          Text(
            valor,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: isDark ? Colors.white : Cores.preto),
          ),
          Text(
            titulo,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: isDark ? Colors.white70 : Colors.grey[700]),
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
              GestureDetector(
                onTap: () => Navigator.pop(context), // Volta para as trilhas
                child: _buildNavItem(Icons.home, 'Início', isDark: isDark),
              ),
              _buildNavItem(Icons.person, 'Perfil', isActive: true, isDark: isDark), // <-- Perfil Ativo!
              const SizedBox(width: 48),
              GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const TelaConquistas())); 
                    // Use pushReplacement nas ecrãs Perfil e Menu, e push apenas na TelaTrilhas
                  },
                  child: _buildNavItem(Icons.star, 'Conquistas', isDark: isDark),
                ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const TelaMenu()));
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