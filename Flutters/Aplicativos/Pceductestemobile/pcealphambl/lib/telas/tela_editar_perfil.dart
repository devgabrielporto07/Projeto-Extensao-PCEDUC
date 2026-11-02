import 'package:flutter/material.dart';
import '../core/cores.dart';
import '../core/tema.dart';
import '../widgets/fundo_pc_educ.dart';
import '../widgets/texto_contorno.dart';

class TelaEditarPerfil extends StatelessWidget {
  const TelaEditarPerfil({super.key});

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
                  
                  // FORMULÁRIO DE EDIÇÃO
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
                          // FOTO DE PERFIL COM ÍCONE DE CÂMERA
                          Center(
                            child: Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Cores.azulFundo,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Cores.preto, width: 3),
                                  ),
                                  child: const Icon(Icons.person, size: 60, color: Cores.branco),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Cores.verdeNeon,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Cores.preto, width: 2),
                                  ),
                                  child: const Icon(Icons.camera_alt, size: 20, color: Cores.preto),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 32),

                          // CAMPOS DE TEXTO
                          _buildCampoTexto('Nome de Utilizador', 'Aluno Hardware', corFundoCartao, corTexto, isDark),
                          const SizedBox(height: 20),
                          _buildCampoTexto('E-mail', 'aluno@email.com', corFundoCartao, corTexto, isDark),
                          
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
                                // Apenas volta para a ecrã de Menu por enquanto
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Salvar Alterações',
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
              'Editar Perfil',
              estilo: Tema.tituloPixel(tamanho: 32, cor: Cores.verdeNeon),
              larguraContorno: 5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCampoTexto(String label, String placeholder, Color fundo, Color corTexto, bool isDark) {
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
            style: TextStyle(color: corTexto, fontWeight: FontWeight.w600),
            decoration: InputDecoration(
              hintText: placeholder,
              hintStyle: TextStyle(color: isDark ? Colors.white54 : Colors.grey),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
          ),
        ),
      ],
    );
  }
}