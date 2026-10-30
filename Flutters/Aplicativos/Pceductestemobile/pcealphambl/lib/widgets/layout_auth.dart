import 'package:flutter/material.dart';
import '../core/cores.dart';
import '../core/tema.dart';
import 'botao_voltar.dart';
import 'fundo_pc_educ.dart';
import 'texto_contorno.dart';

class LayoutAuth extends StatelessWidget {
  const LayoutAuth({
    super.key,
    required this.titulo,
    required this.formulario,
    required this.textoRodape,
    required this.acaoRodape,
    required this.aoToqueRodape,
  });

  final String titulo;
  final Widget formulario;
  final String textoRodape;
  final String acaoRodape; 
  final VoidCallback aoToqueRodape;

  @override
  Widget build(BuildContext context) {
    final tamanho = MediaQuery.sizeOf(context);
    final tamanhoTitulo = (tamanho.width * 0.11).clamp(28.0, 44.0).toDouble();
    final margemInferior = MediaQuery.viewPaddingOf(context).bottom;

    return Scaffold(
      body: FundoPcEduc(
        child: SafeArea(
          bottom: false,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: BotaoVoltar(),
                        ),
                        TextoContorno(
                          titulo,
                          estilo: Tema.tituloPixel(tamanho: tamanhoTitulo),
                          larguraContorno: tamanhoTitulo * 0.18,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Cores.azulClaro,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(28)),
                        border: Border.fromBorderSide(
                          BorderSide(color: Cores.preto, width: 2),
                        ),
                      ),
                      child: CustomScrollView(
                        slivers: [
                          SliverFillRemaining(
                            hasScrollBody: false,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(
                                20,
                                24,
                                20,
                                16 + margemInferior,
                              ),
                              child: Column(
                                children: [
                                  formulario,
                                  const SizedBox(height: 16),
                                  const Spacer(),
                                  Wrap(
                                    alignment: WrapAlignment.center,
                                    crossAxisAlignment: WrapCrossAlignment.center,
                                    children: [
                                      Text(
                                        textoRodape,
                                        style: const TextStyle(color: Cores.preto),
                                      ),
                                      TextButton(
                                        onPressed: aoToqueRodape,
                                        child: Text(
                                          acaoRodape,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w800,
                                            decoration: TextDecoration.underline,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
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
        ),
      ),
    );
  }
}