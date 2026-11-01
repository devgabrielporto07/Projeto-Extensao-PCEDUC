import 'package:flutter/material.dart';
import '../core/cores.dart';
import '../core/tema.dart';
import '../widgets/fundo_pc_educ.dart';
import '../widgets/texto_contorno.dart';
import 'tela_menu.dart';
import 'tela_perfil.dart';

class TelaConquistas extends StatelessWidget {
  const TelaConquistas({super.key});

  @override
  Widget build(BuildContext context) {
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
                  // CABEÇALHO
                  TextoContorno(
                    'Conquistas',
                    estilo: Tema.tituloPixel(tamanho: 44, cor: Cores.verdeNeon),
                    larguraContorno: 8,
                  ),
                  const SizedBox(height: 24),

                  // ÁREA DA LISTA DE CONQUISTAS
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
                          // CONQUISTAS DESBLOQUEADAS (Front-end Estático)
                          _buildCartaoConquista(
                            titulo: 'Primeiro Boot',
                            descricao: 'Concluiu o primeiro nível da Trilha 1.',
                            icone: Icons.power_settings_new,
                            corIcone: Cores.verdeNeon,
                            desbloqueada: true,
                            isDark: isDark,
                          ),
                          const SizedBox(height: 16),
                          
                          _buildCartaoConquista(
                            titulo: 'Estudioso',
                            descricao: 'Alcançou uma ofensiva de 3 dias seguidos.',
                            icone: Icons.local_fire_department,
                            corIcone: Colors.orange,
                            desbloqueada: true,
                            isDark: isDark,
                          ),
                          const SizedBox(height: 16),

                          // CONQUISTAS BLOQUEADAS
                          _buildCartaoConquista(
                            titulo: 'Mestre da Placa-Mãe',
                            descricao: 'Acerte todas as perguntas sobre placas-mãe.',
                            icone: Icons.developer_board,
                            corIcone: Colors.grey,
                            desbloqueada: false,
                            isDark: isDark,
                          ),
                          const SizedBox(height: 16),
                          
                          _buildCartaoConquista(
                            titulo: 'Overclock',
                            descricao: 'Termine uma trilha completa em menos de 24h.',
                            icone: Icons.speed,
                            corIcone: Colors.grey,
                            desbloqueada: false,
                            isDark: isDark,
                          ),
                          
                          const SizedBox(height: 100), // Espaço para não ficar por baixo da navbar
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

  // WIDGET PARA CRIAR CADA CARTÃO DE CONQUISTA
  Widget _buildCartaoConquista({
    required String titulo,
    required String descricao,
    required IconData icone,
    required Color corIcone,
    required bool desbloqueada,
    required bool isDark,
  }) {
    final corFundo = isDark ? const Color(0xFF1E293B) : Cores.branco;
    final corTextoTitulo = isDark ? Colors.white : Cores.preto;
    final corTextoDesc = isDark ? Colors.white70 : Colors.grey[700];

    return Opacity(
      opacity: desbloqueada ? 1.0 : 0.6, // Fica meio transparente se estiver bloqueada
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: corFundo,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Cores.preto, width: 3),
          boxShadow: desbloqueada ? const [BoxShadow(color: Cores.preto, offset: Offset(0, 4))] : null,
        ),
        child: Row(
          children: [
            // Ícone da conquista
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF334155) : const Color(0xFFF1F5F9),
                shape: BoxShape.circle,
                border: Border.all(color: Cores.preto, width: 2),
              ),
              child: Icon(desbloqueada ? icone : Icons.lock, size: 32, color: desbloqueada ? corIcone : Colors.grey),
            ),
            const SizedBox(width: 16),
            
            // Textos
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titulo,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: corTextoTitulo),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    descricao,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: corTextoDesc),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // NAVBAR
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
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const TelaPerfil()));
                },
                child: _buildNavItem(Icons.person, 'Perfil', isDark: isDark),
              ),
              const SizedBox(width: 48),
              
              // CONQUISTAS AGORA ESTÁ ATIVO!
              _buildNavItem(Icons.star, 'Conquistas', isActive: true, isDark: isDark),
              
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