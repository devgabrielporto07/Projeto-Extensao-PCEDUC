# Regras de negócio — Site demonstrativo do PCEDUC

## RN001 — Download desativado enquanto o link estiver vazio
- **Descrição:** cada botão de download (Windows, Android) só fica ativo se houver URL preenchida em
  `LINKS_DOWNLOAD` no `site/js/main.js`. Sem URL: sem `href`, `aria-disabled="true"`, `tabindex="-1"` e selo "Em breve".
- **Entidades:** botões `data-pc-download="windows|android"`, objeto `LINKS_DOWNLOAD`.
- **Exemplo:** `LINKS_DOWNLOAD = { windows: "", android: "https://…/pceduc.apk" }` → Android ativo, Windows "Em breve".

## RN002 — Textos só das fontes oficiais
- **Descrição:** todo texto do site vem do `README.md`, do pitch (`Pitch/PC educ.pdf`) ou do documento de
  requisitos (`PCEDUC-Proposito-e-Requisitos.pdf`), podendo ser encurtado ou adaptado ao nome "PCEDUC" (DEC006).
  Nada de números, depoimentos, funcionalidades ou promessas inventadas.
- **Entidades:** todas as seções (ver `FUNCIONALIDADES.md`).
- **Exemplo:** "O cérebro que executa as instruções." (pitch) — permitido; "Mais de 1.000 alunos já usam" — proibido.

## RN003 — Galeria mostra reservado se a imagem não existe
- **Descrição:** cada item do array `TELAS` aponta para `assets/telas/tela-XX.png`. Se o arquivo não carregar
  (evento `error` da imagem) ou o array estiver vazio, aparece o cartão "Tela em breve" no lugar.
- **Entidades:** array `TELAS`, carrossel da seção `#telas`.
- **Exemplo:** `tela-01.png` existe e `tela-02.png` não → slide 1 mostra a tela, slide 2 mostra "Tela em breve".

## RN004 — Equipe conforme o README
- **Descrição:** a seção Equipe lista exatamente os integrantes e perfis do GitHub da tabela "Equipe" do
  `README.md`, na mesma ordem. Mudou no README, muda no site.
- **Entidades:** seção `#equipe`.
- **Exemplo:** Professora Danielly (@daniellygualberto), Gabriel Porto (@devgabrielporto07), Daniel Mota (@dplayerf),
  Luiz Kaynan (@kaynan-CC), Pedro Vinicius (@PedroVini09), Alfredo Alves (@Alfredinkapps), Sara Arruda (@Sararruda).

## RN005 — Quiz só com conteúdo das fontes e sem valores de XP inventados
- **Descrição:** perguntas, opções, respostas e explicações do mini quiz "Experimente" (`#experimente`) saem das
  fontes oficiais (RN002), podendo ser adaptadas para o formato de pergunta. O feedback de acerto **não mostra
  quantidade de XP** enquanto o valor por acerto não estiver definido nas fontes: usa "+XP" sem número.
- **Entidades:** seção `#experimente`, constantes `QUIZ_ACERTO` e `QUIZ_EXPLICACAO` no `site/js/main.js`.
- **Exemplo:** "Qual peça é o cérebro que executa as instruções?" → Processador (pitch: "O cérebro que executa as
  instruções.") — permitido; feedback "Isso aí! +XP" — permitido; "Isso aí! +10 XP" — proibido.
