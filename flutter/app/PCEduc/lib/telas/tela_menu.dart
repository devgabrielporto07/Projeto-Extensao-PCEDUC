import 'package:flutter/material.dart';
import '../core/cores.dart';
import '../core/tema.dart';
import '../widgets/fundo_pc_educ.dart';
import '../widgets/texto_contorno.dart';
import '../servicos/auth_servico.dart';
import 'tela_login.dart';
import 'tela_perfil.dart';
import 'tela_conquistas.dart';
import 'tela_editar_perfil.dart';
import 'tela_alterar_senha.dart';

class TelaMenu extends StatefulWidget {
  const TelaMenu({super.key});

  @override
  State<TelaMenu> createState() => _TelaMenuState();
}

class _TelaMenuState extends State<TelaMenu> {
  
  // Lógica atualizada para sair da conta do Banco de Dados (Supabase/Firebase)
  void _sairDaConta() async {
    // 1. Desliga a sessão no servidor
    await AuthServico.sair();
    
    // 2. Garante que o ecrã ainda está ativo antes de mudar
    if (!mounted) return; 
    
    // 3. Volta para o Login e apaga o histórico de navegação
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const TelaLogin()),
      (route) => false, 
    );
  }

  @override
  Widget build(BuildContext context) {
    // Ouve as mudanças do modo escuro em tempo real
    return ValueListenableBuilder<bool>(
      valueListenable: Tema.modoEscuro,
      builder: (context, isDark, _) {
        final corFundoCartao = isDark ? Colors.grey[850] : Cores.branco;
        final corTexto = isDark ? Colors.white : Cores.preto;

        return Scaffold(
          extendBody: true,
          body: FundoPcEduc(
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  // CABEÇALHO DO MENU
                  TextoContorno(
                    'Menu',
                    estilo: Tema.tituloPixel(tamanho: 48, cor: Cores.verdeNeon),
                    larguraContorno: 8,
                  ),
                  const SizedBox(height: 24),

                  // ÁREA BRANCA/ESCURA COM OPÇÕES
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0),
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                        border: const Border(top: BorderSide(color: Cores.preto, width: 3)),
                      ),
                      child: ListView(
                        padding: const EdgeInsets.all(20),
                        physics: const BouncingScrollPhysics(),
                        children: [
                          _buildTituloSessao('Conta', corTexto),
                          _buildCartaoBase(
                            corFundoCartao,
                            [
                              _buildItemMenu(
                                  Icons.edit, 
                                  'Editar perfil', 
                                  corTexto, 
                                  traling: Icon(Icons.chevron_right, color: corTexto),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (_) => const TelaEditarPerfil()),
                                    );
                                  },
                                ),
                              _buildLinhaDivisoria(),
                              _buildItemMenu(
                                  Icons.lock, 
                                  'Alterar senha', 
                                  corTexto, 
                                  traling: Icon(Icons.chevron_right, color: corTexto),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (_) => const TelaAlterarSenha()),
                                    );
                                  },
                                ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          _buildTituloSessao('Preferências', corTexto),
                          _buildCartaoBase(
                            corFundoCartao,
                            [
                              _buildItemMenu(Icons.notifications, 'Lembrete diário', corTexto, 
                                traling: _buildSwitch(true, (val) {})),
                              _buildLinhaDivisoria(),
                              _buildItemMenu(Icons.star, 'Sons e efeitos', corTexto, 
                                traling: _buildSwitch(true, (val) {})),
                              _buildLinhaDivisoria(),
                              
                              // BOTÃO DO MODO ESCURO
                              _buildItemMenu(Icons.settings, 'Modo escuro', corTexto, 
                                traling: _buildSwitch(Tema.modoEscuro.value, (val) {
                                  Tema.modoEscuro.value = val; // Atualiza o tema globalmente!
                                })),
                            ],
                          ),
                          const SizedBox(height: 20),

                          _buildTituloSessao('Sobre', corTexto),
                          _buildCartaoBase(
                            corFundoCartao,
                            [
                              _buildItemMenu(Icons.home, 'Sobre o PC-educ', corTexto, traling: Icon(Icons.chevron_right, color: corTexto)),
                              _buildLinhaDivisoria(),
                              
                              // BOTÃO DE SAIR
                              _buildItemMenu(Icons.logout, 'Sair da conta', Cores.erro, 
                                iconColor: Cores.erro, 
                                onTap: _sairDaConta),
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

  // WIDGETS AUXILIARES PARA CONSTRUIR O LAYOUT
  Widget _buildTituloSessao(String titulo, Color corTexto) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 8),
      child: Text(
        titulo,
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: corTexto),
      ),
    );
  }

  Widget _buildCartaoBase(Color? corFundo, List<Widget> filhos) {
    return Container(
      decoration: BoxDecoration(
        color: corFundo,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Cores.preto, width: 2),
      ),
      child: Column(children: filhos),
    );
  }

  Widget _buildItemMenu(IconData icone, String texto, Color corTexto, {Widget? traling, Color? iconColor, VoidCallback? onTap}) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Cores.preto, width: 2),
        ),
        child: Icon(icone, size: 20, color: iconColor ?? Cores.preto),
      ),
      title: Text(
        texto,
        style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: corTexto),
      ),
      trailing: traling,
    );
  }

  Widget _buildLinhaDivisoria() {
    return const Divider(height: 1, thickness: 2, color: Cores.preto);
  }

  // SWITCH ATUALIZADO SEM ERROS NO VS CODE
  Widget _buildSwitch(bool valor, Function(bool) onChanged) {
    return Transform.scale(
      scale: 0.8,
      child: Switch(
        value: valor,
        onChanged: onChanged,
        activeThumbColor: Cores.verdeNeon, 
        activeTrackColor: Cores.preto,
        inactiveThumbColor: Colors.grey,
        inactiveTrackColor: Cores.branco,
        trackOutlineColor: WidgetStateProperty.all(Cores.preto), 
        trackOutlineWidth: WidgetStateProperty.all(2), 
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
              // LIGAÇÃO À TELA INICIAL
              GestureDetector(
                onTap: () => Navigator.pop(context), 
                child: _buildNavItem(Icons.home, 'Início', isDark: isDark),
              ),
              // LIGAÇÃO À TELA DE PERFIL
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const TelaPerfil()));
                },
                child: _buildNavItem(Icons.person, 'Perfil', isDark: isDark),
              ),
              const SizedBox(width: 48),
              
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const TelaConquistas())); 
                  // Use pushReplacement nas ecrãs Perfil e Menu, e push apenas na TelaTrilhas
                },
                child: _buildNavItem(Icons.star, 'Conquistas', isDark: isDark),
              ),
              
              // MENU ESTÁ ATIVO NESTA TELA
              _buildNavItem(Icons.menu, 'Menu', isActive: true, isDark: isDark), 
            ],
          ),
        ),
        
        // BOTÃO CENTRAL VERDE
        Positioned(
          top: -24,
          child: GestureDetector(
            onTap: () => Navigator.pop(context), // Volta para as trilhas
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
            style: TextStyle(
              color: cor,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
      ],
    );
  }
}