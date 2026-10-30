import 'package:flutter/material.dart';
import '../core/cores.dart';
import '../core/tema.dart';
import '../widgets/fundo_pc_educ.dart';
import '../widgets/texto_contorno.dart';
import 'tela_login.dart';

class TelaMenu extends StatefulWidget {
  const TelaMenu({super.key});

  @override
  State<TelaMenu> createState() => _TelaMenuState();
}

class _TelaMenuState extends State<TelaMenu> {
  // Lógica para sair da conta
  void _sairDaConta() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const TelaLogin()),
      (route) => false, // Remove todo o histórico de ecrãs
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Tema.modoEscuro.value;
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
                          _buildItemMenu(Icons.edit, 'Editar perfil', corTexto, traling: const Icon(Icons.chevron_right)),
                          _buildLinhaDivisoria(),
                          _buildItemMenu(Icons.lock, 'Alterar senha', corTexto, traling: const Icon(Icons.chevron_right)),
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
                          _buildItemMenu(Icons.settings, 'Modo escuro', corTexto, 
                            traling: _buildSwitch(Tema.modoEscuro.value, (val) {
                              setState(() {
                                Tema.modoEscuro.value = val;
                              });
                            })),
                        ],
                      ),
                      const SizedBox(height: 20),

                      _buildTituloSessao('Sobre', corTexto),
                      _buildCartaoBase(
                        corFundoCartao,
                        [
                          _buildItemMenu(Icons.home, 'Sobre o PC-educ', corTexto, traling: const Icon(Icons.chevron_right)),
                          _buildLinhaDivisoria(),
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
      bottomNavigationBar: _buildBottomNavBar(context),
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
  Widget _buildBottomNavBar(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: 70,
          decoration: BoxDecoration(
            color: Tema.modoEscuro.value ? Colors.grey[900] : Cores.branco,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            border: const Border(top: BorderSide(color: Cores.preto, width: 3)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context), 
                child: _buildNavItem(Icons.home, 'Início'),
              ),
              _buildNavItem(Icons.person, 'Perfil'),
              const SizedBox(width: 48),
              _buildNavItem(Icons.star, 'Conquistas'),
              _buildNavItem(Icons.menu, 'Menu', isActive: true), // <--- Menu Ativo!
            ],
          ),
        ),
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

  Widget _buildNavItem(IconData icone, String texto, {bool isActive = false}) {
    final corInativo = Tema.modoEscuro.value ? Colors.white54 : const Color(0xFF94A3B8);
    final cor = isActive ? Cores.verdeNeon : corInativo;
    // ... restante da lógica de botões
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Cor do ícone fica preta se ativo, e recebe a cor base se inativo. Se for dark mode e ativo, vamos destacar com verde neon
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