import 'package:flutter/material.dart';
import '../core/cores.dart';

class CampoPcEduc extends StatefulWidget {
  const CampoPcEduc({
    super.key,
    required this.rotulo,
    required this.icone,
    this.dica,
    this.controller,
    this.validator,
    this.ehSenha = false,
    this.tipoTeclado,
    this.acaoTeclado = TextInputAction.next,
  });

  final String rotulo;
  final IconData icone;
  final String? dica;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool ehSenha;
  final TextInputType? tipoTeclado;
  final TextInputAction acaoTeclado;

  @override
  State<CampoPcEduc> createState() => _CampoPcEducState();
}

class _CampoPcEducState extends State<CampoPcEduc> {
  bool _ocultar = true;

  OutlineInputBorder _borda(Color cor) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: cor, width: 2),
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.rotulo,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Cores.preto,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: widget.controller,
          validator: widget.validator,
          obscureText: widget.ehSenha && _ocultar,
          keyboardType: widget.tipoTeclado,
          textInputAction: widget.acaoTeclado,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: const TextStyle(color: Cores.preto),
          decoration: InputDecoration(
            hintText: widget.dica,
            filled: true,
            fillColor: Cores.branco,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
            prefixIcon: Icon(widget.icone, color: Cores.preto),
            suffixIcon: widget.ehSenha
                ? IconButton(
                    icon: Icon(
                      _ocultar
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: Cores.preto,
                    ),
                    onPressed: () => setState(() => _ocultar = !_ocultar),
                  )
                : null,
            enabledBorder: _borda(Cores.preto),
            focusedBorder: _borda(Cores.azulFundo),
            errorBorder: _borda(Cores.erro),
            focusedErrorBorder: _borda(Cores.erro),
            errorStyle: const TextStyle(
              color: Cores.erro,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}