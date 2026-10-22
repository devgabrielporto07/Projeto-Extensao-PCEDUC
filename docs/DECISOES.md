# Decisões — Site demonstrativo do PCEDUC

## DEC001 — Site web estático em `site/`
- **Data:** 2026-10-21
- **Decisão:** o site demonstrativo é uma página única estática (HTML5 + CSS3 + JS), sem back-end, na pasta `site/`.
- **Motivo:** é só apresentação; não há dados nem login. Pasta separada evita publicar o material acadêmico.
- **Alternativas descartadas:** publicar a raiz do repositório; usar gerador de site (Jekyll etc.) — complexidade sem ganho.

## DEC002 — Publicação no GitHub Pages via Actions
- **Data:** 2026-10-21
- **Decisão:** workflow oficial (`.github/workflows/pages.yml`) publica `site/` a cada push na `master` ou manualmente.
- **Motivo:** permite publicar só a subpasta `site/`, sem branch `gh-pages`.
- **Pré-requisitos:** a branch de trabalho precisa chegar à `master` (merge/PR) e o dono do repositório
  (**devgabrielporto07**) precisa ativar `Settings → Pages → Source: GitHub Actions`.
- **Alternativas descartadas:** Pages "Deploy from a branch" (só aceita raiz ou `/docs`, e `docs/` já é a memória do projeto).

## DEC003 — Bootstrap 5.3 via CDN (muda a decisão original "sem framework") — Substituída por DEC013
- **Data:** 2026-10-21
- **Decisão:** usar **Bootstrap 5.3.3** do jsDelivr com versão fixa e `integrity` (SRI) + `crossorigin="anonymous"`:
  - CSS: `https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css`
    `sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH`
  - JS: `https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js`
    `sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz`
  - (hashes conferidos em 2026-10-21 baixando os arquivos do jsDelivr)
- **Uso:** grade, utilitários, navbar com collapse (menu mobile) e carrossel (galeria).
- **Motivo:** pedido do usuário; acelera responsividade e componentes acessíveis prontos.
- **Alternativas descartadas:** CSS/JS puros (decisão original); copiar o Bootstrap para o repositório.

## DEC004 — Variáveis do Bootstrap sobrescritas pelos tokens do PCEDUC — Substituída por DEC013 e DEC015
- **Data:** 2026-10-21
- **Decisão:** `base.css` define os tokens `--pc-*` e sobrescreve `--bs-*` (primária, fonte, corpo, bordas)
  para que os componentes do Bootstrap herdem a identidade visual (ver `IDENTIDADE_VISUAL.md`).
- **Motivo:** evitar visual "Bootstrap padrão" e manter uma única fonte de verdade para cores.

## DEC005 — Seções e ordem da página
- **Data:** 2026-10-21
- **Decisão:** Topo → Por que ensinar hardware → O que é → Como funciona (trilhas → XP → conquistas → peças)
  → O que se aprende (placa-mãe, CPU, GPU, RAM, armazenamento, fonte) → Para quem é → Galeria → Equipe → Download → Rodapé.
  (Na v2 a galeria tem a âncora `#telas` e o topo `#topo`.)
- **Motivo:** segue a narrativa do pitch (`Pitch/PC educ.pdf`), acrescentando peças colecionáveis (requisitos), galeria, equipe e download.

## DEC006 — Nome oficial "PCEDUC"
- **Data:** 2026-10-21
- **Decisão:** o site usa sempre **PCEDUC**. O pitch escreve "PC educ"; textos dele são adaptados para o nome oficial.
- **Motivo:** consistência com README, requisitos e repositório.

## DEC007 — Galeria com espaços reservados — Ajustada por DEC038
- **Data:** 2026-10-21
- **Decisão:** a galeria lista as telas no array do `main.js`; enquanto o PNG não existir em `site/assets/telas/`,
  exibe um cartão "Tela em breve".
- **Motivo:** as telas ainda não foram exportadas do Figma; o site não pode quebrar nem mostrar imagem inventada.
- **Ajuste (DEC038):** o array do `main.js` foi removido; as telas ficam no `index.html` (fonte única). O reservado
  "Tela em breve" continua, agora só para imagem que não carregar.

## DEC008 — Download desativado até haver links
- **Data:** 2026-10-21
- **Decisão:** botões "Baixar para Windows" e "Baixar para Android" ficam desativados (`aria-disabled="true"`,
  sem `href`, fora da ordem de tabulação) com selo "Em breve" enquanto o link estiver vazio. Os links ficam
  centralizados em um único objeto no `main.js`.
- **Motivo:** o app ainda não tem instaladores publicados; um único lugar para trocar os links.
- **Ajuste (DEC038):** `LINKS_DOWNLOAD` passa a ser o único dado editável no topo do `main.js` (o array `TELAS`,
  que ficava ao lado dele, foi removido).

## DEC009 — Mascote animado com quadro parado
- **Data:** 2026-10-21
- **Decisão:** usar o GIF existente `benchware-wave.gif`; com `prefers-reduced-motion: reduce`, mostrar
  `benchware.png` (primeiro quadro, transparente, gerado com GDI+/System.Drawing pelo PowerShell).
- **Motivo:** respeitar quem pede menos movimento sem criar arte nova.

## DEC010 — Divergência de plataforma do app
- **Data:** 2026-10-21
- **Decisão:** registrar que os requisitos (PDF) falam em aplicação web ASP.NET Core MVC mobile-first e o
  README fala em app mobile Flutter. Os botões de download (Windows/Android) seguem o README e a decisão do usuário.
- **Motivo:** não esconder a divergência; a equipe deve alinhar a documentação depois.

## DEC011 — Sem `.env.example`
- **Data:** 2026-10-21
- **Decisão:** não criar `.env`/`.env.example`.
- **Motivo:** site estático sem segredos nem configuração de ambiente.

## DEC012 — `CLAUDE.md` e `.claude/` fora deste repositório
- **Data:** 2026-10-21
- **Decisão:** `.claude/` e `CLAUDE.md` ficam no `.gitignore` deste repositório.
- **Motivo:** decisão do usuário; o repositório é do grupo da faculdade e não deve carregar configuração local dos agentes.
  A memória do projeto continua versionada em `docs/`.

---

## Versão 2 do site (2026-10-21)

A v1 (Bootstrap, tema claro) fica preservada no commit `0fc3109`. As decisões abaixo valem para a v2.

## DEC013 — Bootstrap removido: só HTML5, CSS3 e JavaScript puro
- **Data:** 2026-10-21
- **Decisão:** o site deixa de usar o Bootstrap (CSS e JS do CDN). Layout, grade, menu e carrossel são feitos com
  CSS próprio (Grid/Flexbox) e JavaScript puro. Substitui **DEC003** e **DEC004** (não há mais variáveis `--bs-*`).
- **Motivo:** pedido do usuário para a v2; o visual de trilha gamificada não se beneficia dos componentes do
  Bootstrap e elimina dependência externa (e as hashes SRI a manter).
- **Alternativas descartadas:** manter Bootstrap só para a grade; trocar por outro framework (Tailwind etc.).

## DEC014 — Referência visual: tela da trilha do Duolingo (web)
- **Data:** 2026-10-21
- **Decisão:** a v2 segue o **layout e o estilo** da tela da trilha do app web do Duolingo
  (`docs/referencias/duolingo-trilha-desktop.jpg`), mantendo a essência do PCEDUC: paleta e fontes de
  `IDENTIDADE_VISUAL.md`, mascote Benchware e cartões com contorno e sombra sólida.
- **Limite:** é referência de composição, não cópia. **Não** usar marca, logotipo, personagens, ícones ou textos
  do Duolingo; os textos continuam vindo só das fontes oficiais (RN002).
- **Motivo:** o PCEDUC se apresenta como "no estilo do Duolingo" (pitch/README); o site passa a lembrar a
  experiência do app.

## DEC015 — Tema escuro com a paleta do PCEDUC
- **Data:** 2026-10-21
- **Decisão:** fundo `#141414`, superfícies `#141414` com borda `#4A5868` (2px), texto branco e `#DCEBFD`,
  destaques azul/verde/amarelo da paleta. Tokens novos `--pc-fundo`, `--pc-superficie`, `--pc-borda`,
  `--pc-texto`, `--pc-texto-suave` (ver `IDENTIDADE_VISUAL.md` §9, com tabela de contraste). Substitui a parte de
  cores do **DEC004**.
- **Motivo:** aproxima da referência (DEC014) e valoriza o verde neon e o amarelo, que no fundo escuro têm ótimo contraste.
- **Alternativas descartadas:** tema claro da v1; alternar claro/escuro (complexidade sem pedido).
- **Nota:** complementada por **DEC028** — o tema escuro continua, agora ao lado de um tema claro com botão de alternar.

## DEC016 — Layout: 3 colunas no desktop, abas inferiores no mobile
- **Data:** 2026-10-21
- **Decisão:**
  - **Desktop (≥ 1024px):** 3 colunas — **menu lateral fixo à esquerda** (ícone + rótulo para cada seção);
    **centro** com o conteúdo rolável; **painel direito fixo "Missões do PCEDUC"** com os 4 passos de
    "Como funciona" apresentados como missões, cada uma com **barra amarela** (`--pc-amarelo`) que enche
    conforme a rolagem da página.
  - **Mobile/tablet (< 1024px):** coluna única com **barra de abas inferior** fixa — Início, Aprender, Telas,
    Equipe, Baixar (como no wireframe do app, `Wireframe-Baixa-Fidelidade/Wireframe-PCEDUC.jpeg`);
    o painel de missões (`<aside id="missoes">`) aparece **no fluxo da página**, logo após `#como-funciona`.
- **Acessibilidade:** o texto das missões é sempre visível; a barra é complemento visual. Com
  `prefers-reduced-motion`, a barra atualiza sem transição. Abas com alvo ≥ 44×44px e rótulo visível.
- **Motivo:** reproduz a composição da referência (DEC014) e a navegação do próprio app no celular.
- **Alternativas descartadas:** navbar no topo com menu hambúrguer (v1).

## DEC017 — "O que se aprende" como trilha em zigue-zague
- **Data:** 2026-10-21
- **Decisão:** as 6 peças (placa-mãe, processador, placa de vídeo, memória RAM, armazenamento, fonte de energia)
  viram **botões redondos "3D"** dispostos em zigue-zague, com o Benchware ao lado da trilha e um **baú de peça
  rara** no fim (remete à peça rara-surpresa do README). Clicar (ou Enter/Espaço) em uma peça abre um **balão**
  com a descrição do pitch (F005); Esc ou clique fora fecha.
- **Acessibilidade:** cada peça é `<button>` com `aria-expanded`/`aria-controls` e nome acessível; o balão
  não é a única forma de ler o conteúdo se o JS falhar (sem JS, as descrições ficam visíveis).
- **Motivo:** reproduz a trilha da referência e mostra na prática a ideia de "trilha" do app.

## DEC018 — Faixa de topo da seção atual
- **Data:** 2026-10-21
- **Decisão:** no topo da coluna central, uma faixa azul fixa (estilo "Seção 2, Unidade 7" da referência) mostra
  o nome da seção visível; o item correspondente fica destacado no menu lateral e nas abas inferiores
  (`aria-current="true"`). Detecção com `IntersectionObserver`. Só no desktop e `aria-hidden` (ver DEC023).
- **Contraste:** texto pequeno branco só sobre `--pc-azul-escuro` (`#1D66B8`, 5,76:1); sobre `--pc-azul`
  (`#3391E0`) usar texto `#141414` (5,50:1) ou texto grande branco.
- **Motivo:** orienta o leitor como a faixa de unidade da referência.

## DEC019 — Carrossel da galeria e menu em JavaScript puro
- **Data:** 2026-10-21
- **Decisão:** o carrossel (botões anterior/próximo rotulados, indicadores com `aria-label`, setas do teclado,
  sem autoplay com movimento reduzido) e o destaque do menu/abas são implementados em `main.js`, sem biblioteca.
  Continuam valendo DEC007/RN003 (reservado "Tela em breve").
- **Motivo:** consequência do DEC013.
- **Ajuste (DEC038):** o carrossel passou a usar `scroll-snap` nativo sobre as telas do HTML, com volta circular.

## DEC020 — CSS dividido em quatro arquivos (+ `main.js`)
- **Data:** 2026-10-21 (atualizada após a implementação da v2)
- **Decisão:** `css/base.css` (tokens, reset, tipografia, foco, skip link, movimento reduzido) → `css/layout.css`
  (cabeçalho/menu lateral, colunas, faixa da seção, abas inferiores e **painel de missões**) →
  `css/components.css` (cartões, botões "3D", selos, galeria/carrossel, equipe, download, rodapé, revelar ao rolar)
  → `css/trilha.css` (trilha em zigue-zague, nós 3D, baú, balões, divisor, mascote da trilha). Comportamentos em
  `js/main.js` (`defer`). **Cada arquivo com menos de 600 linhas**; passou disso, dividir por componente.
- **Histórico:** o plano era 3 arquivos CSS; a trilha saiu de `components.css` para respeitar o limite de linhas.
- **Motivo:** uma responsabilidade por arquivo e facilidade de manutenção sem build.

## DEC021 — Pixelify Sans só no peso 400
- **Data:** 2026-10-21
- **Decisão:** os títulos usam Pixelify Sans apenas no peso **400**. O Google Fonts carrega só `Pixelify+Sans:wght@400`
  (Chakra Petch continua 400/600/700). O peso vem do token `--pc-peso-titulo: 400` em `base.css`.
- **Motivo:** nos pesos 500–700 o "C" da Pixelify se fecha e parece "O" — "PCEDUC" era lido como "POEDUO".
- **Alternativas descartadas:** Pixelify 700 nos títulos (plano original); trocar a fonte de títulos.

## DEC022 — Sem cartão de mini status (XP / Nível / Peças)
- **Data:** 2026-10-21
- **Decisão:** o painel direito não tem o cartão de status (XP, nível, peças) que aparece na referência; só "Missões do PCEDUC".
- **Motivo:** não há dados reais para mostrar; números seriam inventados (RN002).

## DEC023 — Faixa "Seção N" só no desktop e `aria-hidden`
- **Data:** 2026-10-21
- **Decisão:** a faixa da seção atual (DEC018) só aparece a partir de 1024px; abaixo disso fica oculta. Ela é
  `aria-hidden="true"`: é decorativa e repete os títulos das seções. A numeração "Seção N" segue a ordem do menu lateral.
- **Motivo:** no celular, a barra de abas já indica a posição; para leitores de tela, anunciar a faixa a cada rolagem seria ruído.
- **Consequência:** o destaque do item ativo no menu/abas é feito só com `aria-current="true"` (não há classe `is-ativo`).

## DEC024 — Menu lateral compacto e destaque translúcido
- **Data:** 2026-10-21
- **Decisão:** entre **1024px e 1279px** o menu lateral mostra só os ícones (rótulo continua acessível a leitores de
  tela); **a partir de 1280px** mostra ícone + rótulo. O item ativo (e o hover) usa fundo `--pc-azul-translucido`
  (`--pc-azul` com 12% de opacidade) e rótulo azul, que mantém ≈ 4,7:1 sobre esse fundo (AA). A mesma cor destaca a aba ativa no mobile.
- **Motivo:** em 1024–1279px as 3 colunas não cabem com rótulos sem espremer o conteúdo central.

## DEC025 — Abas mobile agrupam seções (`data-pc-grupo`)
- **Data:** 2026-10-21
- **Decisão:** a barra de abas (`<nav aria-label="Atalhos">`) tem 5 abas e cada uma fica ativa para um grupo de seções,
  definido no atributo `data-pc-grupo`:
  - **Início** (`#topo`): `topo`, `por-que`, `o-que-e`, `como-funciona`, `missoes`;
  - **Aprender** (`#o-que-se-aprende`): `o-que-se-aprende`, `para-quem`;
  - **Telas** (`#telas`) · **Equipe** (`#equipe`) · **Baixar** (`#download`).
- **Motivo:** 9 seções não cabem em 5 abas; sem agrupamento, nenhuma aba ficaria ativa em parte da página.

## DEC026 — Sombra 3D dos botões amarelos e azul-claro em `--pc-cinza` (provisória)
- **Data:** 2026-10-21
- **Decisão:** nós/selos/botões amarelos (`--pc-amarelo`) e azul-claro (`--pc-azul-claro`) usam sombra sólida
  `--pc-cinza` (`#4A5868`), porque a paleta não tem amarelo escuro nem azul-claro escuro. Resolve a pendência de
  `IDENTIDADE_VISUAL.md` §9.3.
- **Status:** **provisória** — o usuário pode trocar por outra cor; se aprovar um hex novo, ele entra na paleta (§1) antes do uso.
- **Motivo:** não inventar hex fora da paleta oficial.

## DEC027 — Sem JS, o mascote da trilha fica oculto
- **Data:** 2026-10-21
- **Decisão:** o Benchware ao lado da trilha (DEC017) só aparece quando o JS marca a trilha como interativa
  (`pc-trilha--interativa`). Sem JS, ele recebe `display: none`.
- **Motivo:** sem JS os balões das peças ficam abertos (conteúdo sempre legível) e cobririam o mascote, que é decorativo.

## DEC028 — Tema claro e escuro com botão de alternar
- **Data:** 2026-10-21
- **Decisão:** o site passa a ter **tema claro e tema escuro** (complementa DEC015).
  - **Padrão:** segue o sistema (`prefers-color-scheme`).
  - **Botão sol/lua** (`<button class="pc-tema" data-pc-tema>`): no desktop fica no menu lateral, abaixo do logo; no
    mobile, no cabeçalho, à direita do logo. O rótulo (leitor de tela + `title`) diz a **ação**
    ("Ativar tema claro" / "Ativar tema escuro") e o ícone mostra o tema que será ativado.
  - **Escolha salva** em `localStorage`, chave `'pc-tema'`, valores `'claro'` ou `'escuro'`; acesso sempre em
    `try/catch` (com o armazenamento bloqueado, a escolha vale só até recarregar).
  - A escolha vira `data-tema="claro"|"escuro"` no `<html>` e tem prioridade sobre o sistema; as metas
    `theme-color` acompanham o fundo do tema escolhido.
  - **Sem JS** o botão não aparece (`hidden`, removido pelo `main.js`) e o site segue o sistema.
  - Tokens do tema claro e tokens semânticos novos: `IDENTIDADE_VISUAL.md` §10.
- **Motivo:** pedido do usuário; dá escolha a quem prefere fundo claro sem abrir mão do tema escuro da v2.
- **Alternativas descartadas:** só seguir o sistema, sem botão (não deixa escolher); cookie (site estático, sem servidor para ler).

## DEC029 — Exceção à regra "sem `<script>` inline": script de tema no `<head>`
- **Data:** 2026-10-21
- **Decisão:** um script inline **mínimo** no `<head>`, **antes dos CSS**, lê `localStorage['pc-tema']` (em
  `try/catch`) e aplica `data-tema` e a cor das metas `theme-color` antes da primeira pintura. É a única exceção à
  regra de `PADROES.md` §1 (além de JSON-LD, se houver). O resto do comportamento do tema fica em `configurarTema()`
  no `main.js`.
- **Motivo:** o `main.js` usa `defer`; aplicando o tema só nele, quem escolheu o tema oposto ao do sistema veria a
  página piscar no tema errado a cada carregamento.
- **Alternativas descartadas:** aplicar o tema só no `main.js` (flash); arquivo externo síncrono no `<head>`
  (requisição bloqueante extra para poucas linhas).

## DEC030 — Foco, menu lateral e cartões no tema claro
- **Data:** 2026-10-21
- **Decisão:** no tema claro:
  - **foco** passa a `3px solid #1D66B8` (`--pc-azul-escuro`, 5,76:1 sobre branco) — o contorno amarelo do escuro
    daria só 1,55:1 sobre branco;
  - **menu lateral** com fundo branco;
  - **cartões** com sombra sólida `0 4px 0 var(--pc-borda)` (token `--pc-sombra-superficie`).
- **Motivo:** manter o foco visível em WCAG 2.1 AA (≥ 3:1) e a leitura de "cartão 3D" da v2 sobre fundo branco.

## DEC031 — Poses do mascote: 11 PNG transparentes 320×320
- **Data:** 2026-10-21
- **Decisão:** o Benchware ganha **11 poses** em `site/assets/img/mascote/`, todas PNG transparentes de 320×320:
  `acenando`, `construindo`, `correndo`, `diploma`, `duvida`, `errado`, `erro-404`, `formado`, `jogando`,
  `sobrecarregado`, `trofeu`. Uso de cada pose: `IDENTIDADE_VISUAL.md` §5.
- **Origem:** fornecidas pelo usuário como JPG com fundo claro. O fundo foi removido automaticamente: flood fill a
  partir das bordas + remoção das áreas fechadas de fundo com ≥ 350 px (900 px no `diploma`, para preservar o papel)
  e suavização de 2px na borda. Todas conferidas sobre `#141414` (tema escuro) e `#FFFFFF` (tema claro).
- **Motivo:** o mascote acompanha a jornada (pitch); poses diferentes por seção reforçam o assunto de cada uma.
- **Alternativas descartadas:** usar o JPG com fundo (caixa clara visível no tema escuro); repetir o GIF acenando em
  todas as seções (monótono).

## DEC032 — Mapa pose → seção
- **Data:** 2026-10-21
- **Decisão:**

  | Seção | Pose |
  |---|---|
  | `#topo` | GIF acenando (mantido — DEC009) |
  | `#por-que` | `sobrecarregado` (centralizado no cartão) |
  | `#o-que-e` | `jogando` |
  | `#como-funciona` | `correndo` |
  | `#o-que-se-aprende` (trilha) | `construindo`; troca para `trofeu` enquanto o balão do baú estiver aberto (DEC034) |
  | `#experimente` | `duvida` (pergunta) → `trofeu` (acerto) ou `errado` (erro) — DEC035 |
  | `#para-quem` | `formado` |
  | `#equipe` | `diploma` |
  | `#download` | `acenando` (centralizado no cartão) |
  | `404.html` | `erro-404` (DEC036) |

- Nas seções com título, o mascote fica à direita do título (`.pc-secao__cabeca`); nos cartões centralizados
  (`#por-que`, `#download`), acima do título (`.pc-mascote--centro`). Nas seções, as poses são decorativas (`alt=""`).
- **Motivo:** cada pose combina com o assunto da seção, sem acrescentar texto.

## DEC033 — Animações do mascote em duas camadas
- **Data:** 2026-10-21
- **Decisão:** cada mascote é um invólucro `<span class="pc-mascote">` com a `<img class="pc-mascote__img">` dentro:
  - **invólucro:** entrada em **pulo** quando a seção entra na tela (`IntersectionObserver` em `configurarMascotes()`
    põe `is-visivel`; o `<html>` recebe `pc-mascote-ativo`) e **flutuação contínua** (sobe e desce 6px em 3,6s),
    defasada entre as seções (`--pc-mascote-atraso`);
  - **imagem:** **troca de pose** com crossfade + pulinho (`trocarPose()`: uma cópia `.pc-mascote__fantasma` da pose
    antiga some por cima enquanto a nova entra com `is-trocando`) e **giro leve no hover** (só em
    `@media (hover: hover)`; lado alternado por `--pc-mascote-giro`).
  - As poses de reação são pré-carregadas (`preCarregarPoses()`) para a troca não piscar.
  - Com `prefers-reduced-motion: reduce` tudo fica desligado: mascotes visíveis e parados, troca de pose instantânea.
  - Sem `IntersectionObserver` os mascotes ficam visíveis (nada escondido sem JS).
- **Motivo:** a entrada usa `transform` e a flutuação/troca usam `translate`/`scale`/`rotate`; em camadas separadas as
  animações não brigam pela mesma propriedade.
- **Alternativas descartadas:** uma só camada (a flutuação cancelaria a entrada); biblioteca de animação (DEC013).
- **Nota (`IDENTIDADE_VISUAL.md` §6):** a flutuação é o único loop além do GIF do topo, e só existe para quem não pediu menos movimento.

## DEC034 — Baú da "Peça rara" vira botão
- **Data:** 2026-10-21
- **Decisão:** o baú no fim da trilha passa a ser `<button class="pc-no pc-no--bau">` com `aria-expanded`/
  `aria-controls="pc-balao-bau"`, abrindo um balão amarelo como os nós (F020). Texto do balão, já existente no site
  (README/pitch): título "Peça rara" e "Às vezes, uma peça rara aparece como recompensa-surpresa."
  Enquanto o balão do baú estiver aberto, o mascote da trilha troca para `trofeu` (`atualizarMascote()` em
  `configurarTrilha()`, gancho `data-pc-mascote-trilha`); ao fechar ou abrir outro nó, volta para `construindo`.
- **Motivo:** o baú parecia clicável e não fazia nada; agora reforça a recompensa-surpresa (RF09) sem texto novo.

## DEC035 — Mini quiz "Experimente"
- **Data:** 2026-10-21
- **Decisão:** nova seção `#experimente` entre `#o-que-se-aprende` e `#para-quem`, com item "Experimente" no menu
  lateral (10 itens) e no grupo **Aprender** das abas (`data-pc-grupo="o-que-se-aprende experimente para-quem"`).
  - **Pergunta** (baseada no pitch — Processador: "O cérebro que executa as instruções."):
    "Qual peça é o cérebro que executa as instruções?" Opções: **Processador** (correta), Memória RAM, Fonte de energia.
  - **Acerto:** opção em verde (`--pc-verde`, texto escuro) com ✓, rótulo "Correta" e feedback "Isso aí! +XP" —
    **sem número**, pois o valor de XP por acerto não está definido nas fontes (RN005).
  - **Erro:** sem vermelho novo (a paleta não tem vermelho): a opção escolhida fica com fundo `--pc-cinza`, texto
    branco (7,27:1), contorno grosso de 4px na cor do texto, afundada e com ícone ✕, rótulo "Sua resposta"; a correta
    é destacada em verde com ✓ e "Correta"; feedback: "O processador é o cérebro do computador: ele executa as instruções."
  - Botão "Tentar de novo" reinicia (pose volta para `duvida`). Feedback em região `aria-live="polite"`.
  - **Sem JS:** pergunta + `<details>` "Ver resposta" com a resposta e a explicação.
- **Motivo:** dá ao visitante uma amostra do formato de lição do app (múltipla escolha, REQ) usando só conteúdo das fontes.
- **Alternativas descartadas:** vermelho para erro (hex fora da paleta, sem aval); mostrar "+10 XP" (número inventado — RN002).

## DEC036 — Página 404 com caminhos absolutos
- **Data:** 2026-10-21
- **Decisão:** `site/404.html` com o mascote `erro-404`, título "Página não encontrada" e botão "Voltar para o início".
  Carrega `base.css`, `components.css`, `mascote.css` e `erro.css` (sem `layout.css` nem `main.js`; tem o mesmo
  script de tema inline — DEC029) e `meta robots noindex`.
  - **Caminhos absolutos** com o prefixo `/Projeto-Extensao-PCEDUC/` (exceção a `PADROES.md` §1): o Pages serve a 404
    em **qualquer** caminho (ex.: `/Projeto-Extensao-PCEDUC/a/b/c`), e caminhos relativos apontariam para a pasta
    errada. **Se o repositório mudar de nome ou ganhar domínio próprio, trocar o prefixo em todos os links da 404.**
  - **Textos aprovados pelo usuário em 2026-10-21 (RN002):** escritos pela equipe de agentes (não vêm das fontes
    oficiais) e aprovados pelo usuário — "O endereço que você tentou abrir não existe ou mudou de lugar." e o `alt`
    da imagem "Benchware, o mascote do PCEDUC, confuso ao lado do número 404".
  - Ainda não testada no GitHub Pages publicado.
- **Motivo:** a 404 padrão do GitHub não tem a identidade do PCEDUC nem caminho de volta.

## DEC037 — Painel fixo cobre 11 linhas da grade
- **Data:** 2026-10-21
- **Decisão:** em `layout.css` (≥ 1024px), `grid-template-rows: repeat(11, auto)` (era 10): uma linha por filho do
  `<main>` fora o painel (faixa + 10 seções), para o painel "Missões do PCEDUC" (`grid-row: 1 / -1`) cobrir também a
  nova seção `#experimente`.
- **Motivo:** com 10 linhas a seção nova cairia numa linha implícita e o painel fixo terminaria antes dela.
- **Atenção:** ao acrescentar ou remover seção, ajustar esse número.

## DEC038 — Galeria com as telas reais do app (HTML como fonte única)
- **Data:** 2026-10-21
- **Decisão:**
  - **Imagens:** 4 telas reais do protótipo enviadas pelo usuário (em JPG), convertidas em PNG **540×1080** com a
    **moldura do iPhone embutida**; os cantos brancos foram removidos (fundo transparente) e o tamanho foi padronizado.
    Ficam em `site/assets/telas/`: `tela-01.png` (Abertura), `tela-02.png` (Trilhas), `tela-03.png` (Pergunta) e
    `tela-04.png` (Perfil). Como trocar/adicionar: `site/assets/telas/README.md`.
  - **HTML é a fonte única:** cada tela é um `<figure class="pc-galeria__slide">` (com `alt`, `width`/`height` e
    `<figcaption>`) dentro de `[data-pc-galeria-trilho]` na seção `#telas`. O array `TELAS` foi removido do `main.js`;
    `montarGaleria` lê os slides do DOM e só acrescenta controles, indicadores e o aviso (ajusta DEC007 e DEC008).
  - **Sem moldura CSS nas imagens reais** (a PNG já traz a moldura); só a sombra sólida, sem desfoque, em
    `--pc-azul-escuro` (`filter: drop-shadow`). A moldura CSS `.pc-celular` existe apenas no reservado "Tela em breve",
    que o JS põe no lugar de imagem que não carregar (RN003), na mesma proporção 1:2.
  - **Carrossel:** rolagem horizontal nativa com `scroll-snap` (arrastar/deslizar do navegador); "coverflow" leve — a
    tela atual (`is-atual`) em tamanho cheio e as vizinhas com `scale(.86)` e `opacity: .45`; botões
    "Tela anterior"/"Próxima tela" com volta circular (da última para a primeira e vice-versa); indicadores com
    `aria-label` e `aria-current="true"` na tela atual; setas ← → do teclado com foco no carrossel; `aria-live="polite"`
    anunciando "Tela N de 4: Nome" quando o usuário troca; **sem autoplay**; rolagem instantânea com movimento reduzido.
  - **Sem JS:** as telas aparecem do mesmo jeito — lado a lado (4 colunas) quando a coluna é larga e numa faixa
    rolável com `scroll-snap` no celular.
  - CSS próprio em `css/galeria.css` (saiu de `components.css`), carregado logo depois de `components.css`.
- **Motivo:** o usuário enviou as telas reais; com as imagens no HTML a galeria funciona sem JS e há um único lugar
  para editar. O `scroll-snap` dá o arrastar nativo no celular sem biblioteca (DEC013, DEC019).
- **Alternativas descartadas:** manter o array `TELAS` no JS (conteúdo some sem JS e fica duplicado); moldura CSS
  sobre as PNG (moldura dupla); autoplay (atrapalha a leitura e a acessibilidade).
- **Pendência:** conferir a rolagem suave dos botões/teclado em navegador real (Chrome, Firefox, Safari/iOS).
