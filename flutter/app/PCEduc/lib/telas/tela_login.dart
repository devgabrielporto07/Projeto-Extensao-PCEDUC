import 'package:flutter/material.dart';
import '../core/cores.dart';
import '../core/validadores.dart';
import '../servicos/auth_servico.dart';
import '../widgets/botao_pc_educ.dart';
import '../widgets/campo_pc_educ.dart';
import '../widgets/layout_auth.dart';
import '../widgets/secao_social.dart';
import 'tela_cadastro.dart';
import 'tela_trilhas.dart';


class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key, this.emailInicial});

  // Vem preenchido quando a pessoa acabou de criar a conta
  final String? emailInicial;

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _email;
  final _senha = TextEditingController();
  bool _entrando = false;

  @override
  void initState() {
    super.initState();
    _email = TextEditingController(text: widget.emailInicial);
  }

  @override
  void dispose() {
    _email.dispose();
    _senha.dispose();
    super.dispose();
  }

  String? _validarSenha(String? v) {
    if (v == null || v.isEmpty) return 'Digite sua senha.';
    return null;
  }

  Future<void> _entrar() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;

    setState(() => _entrando = true);
    final erro = await AuthServico.entrar(
      email: _email.text.trim(),
      senha: _senha.text,
    );
    if (!mounted) return;
    setState(() => _entrando = false);

    if (erro != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(erro)));
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const TelaTrilhas()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutAuth(
      titulo: 'Entrar',
      textoRodape: 'Ainda não tem conta?',
      acaoRodape: 'Criar conta',
      aoToqueRodape: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const TelaCadastro()),
        );
      },
      formulario: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Que bom te ver de novo!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Cores.preto,
              ),
            ),
            const SizedBox(height: 16),
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
              dica: 'Sua senha',
              ehSenha: true,
              controller: _senha,
              validator: _validarSenha,
              acaoTeclado: TextInputAction.done,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Recuperação de senha em breve.')),
                  );
                },
                child: const Text(
                  'Esqueci minha senha',
                  style: TextStyle(
                    color: Cores.azulFundo,
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            BotaoPcEduc(
              texto: _entrando ? 'Entrando...' : 'Entrar',
              aoPressionar: _entrando ? null : _entrar,
            ),
            const SizedBox(height: 16),
            SecaoSocial(
              textoDivisor: 'ou entre com',
              aoPressionarApple: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const TelaTrilhas()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}