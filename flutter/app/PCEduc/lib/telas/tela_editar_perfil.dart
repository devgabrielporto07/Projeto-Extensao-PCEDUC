import 'package:flutter/material.dart';
import '../core/cores.dart';
import '../core/tema.dart';
import '../core/validadores.dart';
import '../servicos/perfil_servico.dart';
import '../widgets/fundo_pc_educ.dart';
import '../widgets/texto_contorno.dart';

/// Visual do Alfredo + ligação com o banco (PerfilServico).
/// Edita nome e @usuario. O e-mail aparece só para leitura e a foto ainda não troca.
class TelaEditarPerfil extends StatefulWidget {
  const TelaEditarPerfil({super.key});

  @override
  State<TelaEditarPerfil> createState() => _TelaEditarPerfilState();
}

class _TelaEditarPerfilState extends State<TelaEditarPerfil> {
  final _formKey = GlobalKey<FormState>();
  final _nome = TextEditingController();
  final _usuario = TextEditingController();
  final _email = TextEditingController();

  // A função do banco grava nome, @usuario e foto juntos (nulo apaga a foto).
  // Por isso guardamos a foto atual e reenviamos igual ao salvar.
  String? _fotoUrl;

  bool _carregando = true;
  bool _salvando = false;

  @override
  void initState() {
    super.initState();
    _carregar();
  }

  @override
  void dispose() {
    _nome.dispose();
    _usuario.dispose();
    _email.dispose();
    super.dispose();
  }

  Future<void> _carregar() async {
    final perfil = await PerfilServico.carregar();
    if (!mounted) return;

    if (perfil == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Não foi possível carregar seu perfil.')),
      );
      Navigator.pop(context);
      return;
    }

    setState(() {
      _nome.text = perfil.nome ?? perfil.nomeSugerido ?? '';
      _usuario.text = perfil.usuario ?? '';
      _email.text = perfil.email ?? '';
      _fotoUrl = perfil.fotoUrl;
      _carregando = false;
    });
  }

  String? _validarNome(String? v) {
    final texto = v?.trim() ?? '';
    if (texto.isEmpty) return 'Digite seu nome.';
    if (texto.length < 2) return 'Use pelo menos 2 caracteres.';
    if (texto.length > 50) return 'Use no máximo 50 caracteres.';
    return null;
  }

  Future<void> _salvar() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;

    setState(() => _salvando = true);
    final erro = await PerfilServico.atualizar(
      nome: _nome.text.trim(),
      usuario: _usuario.text.trim().toLowerCase(),
      fotoUrl: _fotoUrl,
    );
    if (!mounted) return;
    setState(() => _salvando = false);

    if (erro != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(erro)));
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Perfil atualizado!')),
    );
    Navigator.pop(context, true);
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

                  // FORMULÁRIO DE EDIÇÃO
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF0F172A) : const Color(0xFFE2E8F0),
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                        border: const Border(top: BorderSide(color: Cores.preto, width: 3)),
                      ),
                      child: _carregando
                          ? const Center(child: CircularProgressIndicator())
                          : Form(
                              key: _formKey,
                              child: ListView(
                                padding: const EdgeInsets.all(24),
                                physics: const BouncingScrollPhysics(),
                                children: [
                                  _buildAvatar(),
                                  const SizedBox(height: 32),

                                  // CAMPOS DE TEXTO
                                  _buildCampoTexto(
                                    'Nome', 'Como quer ser chamado',
                                    corFundoCartao, corTexto, isDark,
                                    controller: _nome,
                                    validator: _validarNome,
                                  ),
                                  const SizedBox(height: 20),
                                  _buildCampoTexto(
                                    'Nome de usuário', 'seu.usuario',
                                    corFundoCartao, corTexto, isDark,
                                    controller: _usuario,
                                    validator: Validadores.usuario,
                                  ),
                                  const SizedBox(height: 20),
                                  _buildCampoTexto(
                                    'E-mail', '',
                                    corFundoCartao, corTexto, isDark,
                                    controller: _email,
                                    somenteLeitura: true,
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
                                        _salvando ? 'Salvando...' : 'Salvar Alterações',
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
              'Editar Perfil',
              estilo: Tema.tituloPixel(tamanho: 32, cor: Cores.verdeNeon),
              larguraContorno: 5,
            ),
          ),
        ],
      ),
    );
  }

  // FOTO DE PERFIL COM ÍCONE DE CÂMERA (a troca de foto ainda não está pronta)
  Widget _buildAvatar() {
    final temFoto = _fotoUrl != null && _fotoUrl!.isNotEmpty;

    return Center(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            width: 100,
            height: 100,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: Cores.azulFundo,
              shape: BoxShape.circle,
              border: Border.all(color: Cores.preto, width: 3),
            ),
            child: temFoto
                ? Image.network(
                    _fotoUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stack) =>
                        const Icon(Icons.person, size: 60, color: Cores.branco),
                  )
                : const Icon(Icons.person, size: 60, color: Cores.branco),
          ),
          GestureDetector(
            onTap: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('A troca de foto chega em breve.')),
            ),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Cores.verdeNeon,
                shape: BoxShape.circle,
                border: Border.all(color: Cores.preto, width: 2),
              ),
              child: const Icon(Icons.camera_alt, size: 20, color: Cores.preto),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCampoTexto(
    String label,
    String placeholder,
    Color fundo,
    Color corTexto,
    bool isDark, {
    required TextEditingController controller,
    String? Function(String?)? validator,
    bool somenteLeitura = false,
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
            color: somenteLeitura ? fundo.withValues(alpha: 0.6) : fundo,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Cores.preto, width: 2),
          ),
          child: TextFormField(
            controller: controller,
            validator: validator,
            readOnly: somenteLeitura,
            enabled: !_salvando,
            style: TextStyle(
              color: somenteLeitura ? corTexto.withValues(alpha: 0.6) : corTexto,
              fontWeight: FontWeight.w600,
            ),
            decoration: InputDecoration(
              hintText: placeholder,
              hintStyle: TextStyle(color: isDark ? Colors.white54 : Colors.grey),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              suffixIcon: somenteLeitura
                  ? Icon(Icons.lock_outline, color: isDark ? Colors.white54 : Colors.grey)
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}