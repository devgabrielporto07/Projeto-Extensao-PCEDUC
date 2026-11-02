import 'package:flutter/material.dart';
import '../core/cores.dart';
import '../core/tema.dart';
import '../widgets/fundo_pc_educ.dart';
import '../widgets/texto_contorno.dart';

class TelaAlterarSenha extends StatelessWidget {
  const TelaAlterarSenha({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: Tema.modoEscuro,
      builder: (context, isDark, _) {
        final corTexto = isDark ? Colors.white : Cores.preto;
        final corFundoCartao = isDark ? const Color(0xFF1E293B) : Cores.branco;

        return Scaffold(
          extendBody: true,
          body: FundoPcEduc(
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  // CABEÇALHO COM BOTÃO DE VOLTAR
                  _buildCabecalho(context, isDark),
                  
                  // FORMULÁRIO DE ALTERAÇÃO
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF0F172A) : const Color(0xFFE2E8F0),
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                        border: const Border(top: BorderSide(color: Cores.preto, width: 3)),
                      ),
                      child: ListView(
                        padding: const EdgeInsets.all(24),
                        physics: const BouncingScrollPhysics(),
                        children: [
                          // ÍCONE DE CADEADO NO TOPO
                          Center(
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: isDark ? const Color(0xFF334155) : const Color(0xFFF1F5F9),
                                shape: BoxShape.circle,
                                border: Border.all(color: Cores.preto, width: 3),
                              ),
                              child: const Icon(Icons.lock_reset, size: 40, color: Colors.grey),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Crie uma senha forte com letras e números para proteger o seu progresso.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 13, 
                              fontWeight: FontWeight.w600, 
                              color: isDark ? Colors.white70 : Colors.grey[700]
                            ),
                          ),
                          const SizedBox(height: 32),

                          // CAMPOS DE SENHA (com obscureText ativado)
                          _buildCampoSenha('Senha Atual', '••••••••', corFundoCartao, corTexto, isDark),
                          const SizedBox(height: 20),
                          _buildCampoSenha('Nova Senha', '••••••••', corFundoCartao, corTexto, isDark),
                          const SizedBox(height: 20),
                          _buildCampoSenha('Confirmar Nova Senha', '••••••••', corFundoCartao, corTexto, isDark),
                          
                          const SizedBox(height: 40),
                          
                          // BOTÃO DE SALVAR
                          SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Cores.verdeNeon,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  side: const BorderSide(color: Cores.preto, width: 3),
                                ),
                                elevation: 0,
                              ),
                              onPressed: () {
                                // Apenas volta para o Menu simulando que guardou
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Atualizar Senha',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                  color: Cores.preto,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCabecalho(BuildContext context, bool isDark) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: isDark ? Colors.grey[800] : Cores.branco,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Cores.preto, width: 2),
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios_new, color: isDark ? Colors.white : Cores.preto, size: 20),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: TextoContorno(
              'Alterar Senha',
              estilo: Tema.tituloPixel(tamanho: 28, cor: Cores.verdeNeon),
              larguraContorno: 5,
            ),
          ),
        ],
      ),
    );
  }

  // WIDGET ESPECÍFICO PARA SENHAS (Esconde o texto e tem o ícone de olho)
  Widget _buildCampoSenha(String label, String placeholder, Color fundo, Color corTexto, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: corTexto),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: fundo,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Cores.preto, width: 2),
          ),
          child: TextField(
            obscureText: true, // <-- Isto é o que esconde a senha (transforma em bolinhas)
            style: TextStyle(color: corTexto, fontWeight: FontWeight.w600),
            decoration: InputDecoration(
              hintText: placeholder,
              hintStyle: TextStyle(color: isDark ? Colors.white54 : Colors.grey),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              suffixIcon: Icon(Icons.visibility_off, color: isDark ? Colors.white54 : Colors.grey),
            ),
          ),
        ),
      ],
    );
  }
}