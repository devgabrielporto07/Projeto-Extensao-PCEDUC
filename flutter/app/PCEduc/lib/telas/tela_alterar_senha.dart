import 'package:flutter/material.dart';
import '../core/cores.dart';
import '../core/tema.dart';
import '../core/validadores.dart';
import '../servicos/auth_servico.dart';
import '../widgets/fundo_pc_educ.dart';
import '../widgets/texto_contorno.dart';

/// Visual do Alfredo + ligação com o Supabase (AuthServico.alterarSenha).
class TelaAlterarSenha extends StatefulWidget {
  const TelaAlterarSenha({super.key});

  @override
  State<TelaAlterarSenha> createState() => _TelaAlterarSenhaState();
}

class _TelaAlterarSenhaState extends State<TelaAlterarSenha> {
  final _formKey = GlobalKey<FormState>();
  final _atual = TextEditingController();
  final _nova = TextEditingController();
  final _confirmar = TextEditingController();

  bool _ocultaAtual = true;
  bool _ocultaNova = true;
  bool _ocultaConfirmar = true;
  bool _salvando = false;

  @override
  void dispose() {
    _atual.dispose();
    _nova.dispose();
    _confirmar.dispose();
    super.dispose();
  }

  String? _validarAtual(String? v) {
    if (v == null || v.isEmpty) return 'Digite sua senha atual.';
    return null;
  }

  String? _validarNova(String? v) {
    // Mesmas regras do cadastro (6+ caracteres, maiúscula, minúscula, número, símbolo)
    final erro = Validadores.senha(v);
    if (erro != null) return erro;
    if (v == _atual.text) return 'A nova senha precisa ser diferente da atual.';
    return null;
  }

  String? _validarConfirmacao(String? v) {
    if (v != _nova.text) return 'As senhas não são iguais.';
    return null;
  }

  Future<void> _salvar() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;

    setState(() => _salvando = true);
    final erro = await AuthServico.alterarSenha(
      senhaAtual: _atual.text,
      novaSenha: _nova.text,
    );
    if (!mounted) return;
    setState(() => _salvando = false);

    if (erro != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(erro)));
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Senha alterada com sucesso!')),
    );
    Navigator.pop(context);
  }

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
                      child: Form(
                        key: _formKey,
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
                              'Use 6 ou mais caracteres, com letra maiúscula, minúscula, número e símbolo.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: isDark ? Colors.white70 : Colors.grey[700],
                              ),
                            ),
                            const SizedBox(height: 32),

                            // CAMPOS DE SENHA
                            _buildCampoSenha(
                              'Senha Atual', corFundoCartao, corTexto, isDark,
                              controller: _atual,
                              validator: _validarAtual,
                              oculto: _ocultaAtual,
                              alternar: () => setState(() => _ocultaAtual = !_ocultaAtual),
                            ),
                            const SizedBox(height: 20),
                            _buildCampoSenha(
                              'Nova Senha', corFundoCartao, corTexto, isDark,
                              controller: _nova,
                              validator: _validarNova,
                              oculto: _ocultaNova,
                              alternar: () => setState(() => _ocultaNova = !_ocultaNova),
                            ),
                            const SizedBox(height: 20),
                            _buildCampoSenha(
                              'Confirmar Nova Senha', corFundoCartao, corTexto, isDark,
                              controller: _confirmar,
                              validator: _validarConfirmacao,
                              oculto: _ocultaConfirmar,
                              alternar: () => setState(() => _ocultaConfirmar = !_ocultaConfirmar),
                              ultimo: true,
                            ),

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
                                onPressed: _salvando ? null : _salvar,
                                child: Text(
                                  _salvando ? 'Salvando...' : 'Atualizar Senha',
                                  style: const TextStyle(
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

  // CAMPO DE SENHA (esconde o texto e tem o ícone de olho que alterna)
  Widget _buildCampoSenha(
    String label,
    Color fundo,
    Color corTexto,
    bool isDark, {
    required TextEditingController controller,
    required String? Function(String?) validator,
    required bool oculto,
    required VoidCallback alternar,
    bool ultimo = false,
  }) {
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
          child: TextFormField(
            controller: controller,
            validator: validator,
            obscureText: oculto,
            enabled: !_salvando,
            textInputAction: ultimo ? TextInputAction.done : TextInputAction.next,
            onFieldSubmitted: ultimo ? (_) => _salvar() : null,
            style: TextStyle(color: corTexto, fontWeight: FontWeight.w600),
            decoration: InputDecoration(
              hintText: '••••••••',
              hintStyle: TextStyle(color: isDark ? Colors.white54 : Colors.grey),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              suffixIcon: IconButton(
                icon: Icon(
                  oculto ? Icons.visibility_off : Icons.visibility,
                  color: isDark ? Colors.white54 : Colors.grey,
                ),
                onPressed: alternar,
              ),
            ),
          ),
        ),
      ],
    );
  }
}