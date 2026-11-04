import 'dart:async';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../core/cores.dart';
import '../servicos/auth_servico.dart';
import '../servicos/perfil_servico.dart';
import '../telas/tela_editar_perfil.dart';
import '../telas/tela_trilhas.dart';
import 'botao_social.dart';

class SecaoSocial extends StatefulWidget {
  const SecaoSocial({
    super.key,
    required this.textoDivisor,
    this.aoPressionarApple, // atalho de teste do botão da maçã (ver observação na conversa)
  });

  final String textoDivisor;
  final VoidCallback? aoPressionarApple;

  @override
  State<SecaoSocial> createState() => _SecaoSocialState();
}

class _SecaoSocialState extends State<SecaoSocial> {
  StreamSubscription<AuthState>? _escuta;

  @override
  void dispose() {
    _escuta?.cancel();
    super.dispose();
  }

  Future<void> _entrarComGoogle() async {
    // Começa a escutar ANTES de abrir o navegador, para não perder o aviso de retorno.
    _escuta?.cancel();
    _escuta = AuthServico.aoMudar.listen((estado) {
      if (estado.event == AuthChangeEvent.signedIn && estado.session != null) {
        _escuta?.cancel();
        _aoEntrar();
      }
    });

    final erro = await AuthServico.entrarComGoogle();
    if (erro != null && mounted) {
      _escuta?.cancel();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(erro)));
    }
  }

  Future<void> _aoEntrar() async {
    if (!mounted) return;
    final navegador = Navigator.of(context);

    // Quem entra pelo Google chega sem @usuario: pede para completar o perfil antes.
    final perfil = await PerfilServico.carregar();
    if (!mounted) return;

    if (perfil != null && (perfil.usuario == null || perfil.usuario!.isEmpty)) {
      await navegador.push(
        MaterialPageRoute(builder: (_) => const TelaEditarPerfil()),
      );
      if (!mounted) return;
    }

    navegador.pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const TelaTrilhas()),
      (rota) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            const Expanded(child: Divider(color: Cores.preto)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                widget.textoDivisor,
                style: const TextStyle(color: Cores.preto, fontSize: 13),
              ),
            ),
            const Expanded(child: Divider(color: Cores.preto)),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: BotaoSocial(
                icone: const Icon(Icons.g_mobiledata, size: 34),
                aoPressionar: _entrarComGoogle,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: BotaoSocial(
                icone: const Icon(Icons.apple, size: 26),
                aoPressionar: widget.aoPressionarApple,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: BotaoSocial(
                icone: const Icon(Icons.forum, size: 24),
                aoPressionar: () {},
              ),
            ),
          ],
        ),
      ],
    );
  }
}