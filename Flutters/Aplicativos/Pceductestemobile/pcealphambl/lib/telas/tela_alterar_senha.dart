import 'package:flutter/material.dart';
import '../core/validadores.dart';
import '../servicos/auth_servico.dart';
import '../widgets/botao_pc_educ.dart';
import '../widgets/campo_pc_educ.dart';
import '../widgets/layout_auth.dart';

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
    return LayoutAuth(
      titulo: 'Nova senha',
      textoRodape: 'Mudou de ideia?',
      acaoRodape: 'Voltar',
      aoToqueRodape: () => Navigator.pop(context),
      formulario: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CampoPcEduc(
              rotulo: 'Senha atual',
              icone: Icons.lock_outline,
              dica: 'Sua senha de hoje',
              ehSenha: true,
              controller: _atual,
              validator: _validarAtual,
            ),
            const SizedBox(height: 14),
            CampoPcEduc(
              rotulo: 'Nova senha',
              icone: Icons.lock_outline,
              dica: 'Letras, número e símbolo',
              ehSenha: true,
              controller: _nova,
              validator: _validarNova,
            ),
            const SizedBox(height: 14),
            CampoPcEduc(
              rotulo: 'Confirmar nova senha',
              icone: Icons.lock_outline,
              dica: 'Repita a nova senha',
              ehSenha: true,
              controller: _confirmar,
              validator: _validarConfirmacao,
              acaoTeclado: TextInputAction.done,
            ),
            const SizedBox(height: 20),
            BotaoPcEduc(
              texto: _salvando ? 'Salvando...' : 'Salvar nova senha',
              aoPressionar: _salvando ? null : _salvar,
            ),
          ],
        ),
      ),
    );
  }
}
