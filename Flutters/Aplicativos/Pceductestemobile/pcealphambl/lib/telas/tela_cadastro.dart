import 'package:flutter/material.dart';
import '../core/validadores.dart';
import '../servicos/auth_servico.dart';
import '../widgets/botao_pc_educ.dart';
import '../widgets/campo_pc_educ.dart';
import '../widgets/layout_auth.dart';
import '../widgets/secao_social.dart';
import 'tela_login.dart';

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({super.key});

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  final _formKey = GlobalKey<FormState>();
  final _usuario = TextEditingController();
  final _email = TextEditingController();
  final _senha = TextEditingController();
  final _confirmar = TextEditingController();
  bool _salvando = false;

  @override
  void dispose() {
    _usuario.dispose();
    _email.dispose();
    _senha.dispose();
    _confirmar.dispose();
    super.dispose();
  }

  String? _validarConfirmacao(String? v) {
    if (v != _senha.text) return 'As senhas não são iguais.';
    return null;
  }

  Future<void> _criarConta() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;

    final email = _email.text.trim(); // guardo agora, antes de sair da tela

    setState(() => _salvando = true);
    final erro = await AuthServico.cadastrar(
      usuario: _usuario.text.trim(),
      email: email,
      senha: _senha.text,
    );
    if (!mounted) return;
    setState(() => _salvando = false);

    if (erro != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(erro)));
      return;
    }

    // Cadastro salvo: avisa e leva para a tela de Entrar, com o e-mail preenchido
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Conta criada! Agora é só entrar.')),
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => TelaLogin(emailInicial: email)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutAuth(
      titulo: 'Criar conta',
      textoRodape: 'Já tem conta?',
      acaoRodape: 'Entrar',
      aoToqueRodape: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const TelaLogin()),
        );
      },
      formulario: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CampoPcEduc(
              rotulo: 'Nome de usuário',
              icone: Icons.person_outline,
              dica: '@seu.usuario',
              controller: _usuario,
              validator: Validadores.usuario,
            ),
            const SizedBox(height: 14),
            CampoPcEduc(
              rotulo: 'E-mail',
              icone: Icons.mail_outline,
              dica: 'seuemail@exemplo.com',
              tipoTeclado: TextInputType.emailAddress,
              controller: _email,
              validator: Validadores.email,
            ),
            const SizedBox(height: 14),
            CampoPcEduc(
              rotulo: 'Senha',
              icone: Icons.lock_outline,
              dica: 'Mínimo 6 caracteres',
              ehSenha: true,
              controller: _senha,
              validator: Validadores.senha,
            ),
            const SizedBox(height: 14),
            CampoPcEduc(
              rotulo: 'Confirmar senha',
              icone: Icons.lock_outline,
              dica: 'Repita a senha',
              ehSenha: true,
              controller: _confirmar,
              validator: _validarConfirmacao,
              acaoTeclado: TextInputAction.done,
            ),
            const SizedBox(height: 20),
            BotaoPcEduc(
              texto: _salvando ? 'Criando...' : 'Criar conta',
              aoPressionar: _salvando ? null : _criarConta,
            ),
            const SizedBox(height: 16),
            const SecaoSocial(textoDivisor: 'ou cadastre-se'),
          ],
        ),
      ),
    );
  }
}