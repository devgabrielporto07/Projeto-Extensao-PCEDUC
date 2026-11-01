import 'package:flutter/material.dart';
import '../core/validadores.dart';
import '../servicos/perfil_servico.dart';
import '../widgets/botao_pc_educ.dart';
import '../widgets/campo_pc_educ.dart';
import '../widgets/layout_auth.dart';

class TelaEditarPerfil extends StatefulWidget {
  const TelaEditarPerfil({super.key});

  @override
  State<TelaEditarPerfil> createState() => _TelaEditarPerfilState();
}

class _TelaEditarPerfilState extends State<TelaEditarPerfil> {
  final _formKey = GlobalKey<FormState>();
  final _nome = TextEditingController();
  final _usuario = TextEditingController();

  // A foto ainda não é editada aqui. Guardamos a atual e reenviamos igual,
  // porque a função do banco grava os 3 campos juntos (nulo apagaria a foto).
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
      _nome.text = perfil.nome ?? '';
      _usuario.text = perfil.usuario ?? '';
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
    return LayoutAuth(
      titulo: 'Seu perfil',
      textoRodape: 'Mudou de ideia?',
      acaoRodape: 'Voltar',
      aoToqueRodape: () => Navigator.pop(context),
      formulario: _carregando
          ? const Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: Center(child: CircularProgressIndicator()),
            )
          : Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CampoPcEduc(
                    rotulo: 'Nome',
                    icone: Icons.badge_outlined,
                    dica: 'Como quer ser chamado',
                    controller: _nome,
                    validator: _validarNome,
                  ),
                  const SizedBox(height: 14),
                  CampoPcEduc(
                    rotulo: 'Nome de usuário',
                    icone: Icons.person_outline,
                    dica: 'seu.usuario',
                    controller: _usuario,
                    validator: Validadores.usuario,
                    acaoTeclado: TextInputAction.done,
                  ),
                  const SizedBox(height: 20),
                  BotaoPcEduc(
                    texto: _salvando ? 'Salvando...' : 'Salvar',
                    aoPressionar: _salvando ? null : _salvar,
                  ),
                ],
              ),
            ),
    );
  }
}
