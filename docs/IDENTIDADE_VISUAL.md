# Identidade visual — PCEDUC

Visual lúdico de "jogo retrô": tipografia pixelada nos títulos, contornos escuros, sombras sólidas,
azul como cor principal, verde neon para XP e amarelo para conquistas. Mascote: **Benchware**.

## 1. Paleta e tokens CSS

Definidos em `site/css/base.css`, dentro de `:root`. Use **sempre o token**, nunca o hex solto.
A coluna "Uso" abaixo é do tema claro (v1); na v2 vale o tema escuro da §9, que reaproveita estes mesmos tokens.

| Token | Hex | Nome | Uso |
|---|---|---|---|
| `--pc-azul` | `#3391E0` | Azul primário | Destaques, ícones, fundos grandes com texto grande |
| `--pc-azul-escuro` | `#1D66B8` | Azul escuro | Botões, links, fundos com texto pequeno branco |
| `--pc-azul-claro` | `#DCEBFD` | Azul claro | Fundo de seções alternadas |
| `--pc-verde` | `#33FF00` | Verde neon | XP, barras de progresso, botão de destaque (texto escuro) |
| `--pc-verde-escuro` | `#1E9E00` | Verde escuro | Detalhes, bordas do verde, texto grande branco |
| `--pc-amarelo` | `#FFC83D` | Amarelo | Conquistas, selos ("Em breve") |
| `--pc-preto` | `#141414` | Quase preto | Texto principal, contornos, sombras |
| `--pc-cinza` | `#4A5868` | Cinza | Texto secundário |
| `--pc-branco` | `#FFFFFF` | Branco | Fundo base, texto sobre azul escuro |

Overrides do Bootstrap (`--bs-*`, DEC004): **removidos na v2** (DEC013 — o site não usa mais Bootstrap).
Não criar variáveis `--bs-*`; use só os tokens `--pc-*`. A tabela original fica no histórico do Git (commit `0fc3109`).

## 2. Tipografia

| Token | Valor | Uso |
|---|---|---|
| `--pc-fonte-titulo` | `"Pixelify Sans", "Courier New", monospace` | h1–h3, números de XP, selos |
| `--pc-fonte-texto` | `"Chakra Petch", "Segoe UI", system-ui, sans-serif` | Textos, botões, menu |

- Google Fonts com `display=swap` e `preconnect` para `fonts.googleapis.com` e `fonts.gstatic.com`.
  Pesos: **Pixelify Sans só 400** (DEC021 — nos pesos 500–700 o "C" fecha e "PCEDUC" vira "POEDUO"; token
  `--pc-peso-titulo: 400`); Chakra Petch 400/600/700.
- Tamanhos com `clamp()` (fluido); texto de corpo mínimo 1rem; Pixelify Sans só em títulos (é menos legível em blocos).

## 3. Espaçamentos, raios, contornos e sombras

| Token | Valor | Uso |
|---|---|---|
| `--pc-espaco-1` … `--pc-espaco-6` | `0.25rem`, `0.5rem`, `1rem`, `1.5rem`, `2.5rem`, `4rem` | Margens e paddings  |
| `--pc-raio` | `0.75rem` | Cartões, botões |
| `--pc-raio-pequeno` | `0.375rem` | Selos, miniaturas |
| `--pc-contorno` | `3px solid var(--pc-preto)` | Cartões, botões, molduras (2px em telas pequenas) |
| `--pc-sombra` | `4px 4px 0 var(--pc-preto)` | Sombra sólida, sem desfoque |
| `--pc-sombra-hover` | `6px 6px 0 var(--pc-preto)` | Hover/foco de cartões e botões |
| `--pc-foco` | `3px solid var(--pc-amarelo)` + `outline-offset: 3px` | Foco visível (`:focus-visible`) |
| `--pc-transicao` | `180ms ease-out` | Transições leves |

**Cartões:** fundo branco, `--pc-contorno`, `--pc-sombra`, `--pc-raio`. Hover: `translate(-2px, -2px)` + `--pc-sombra-hover`. (v1 — no tema escuro da v2, ver §9)

## 4. Contraste (WCAG 2.1 AA)

Razões calculadas pela fórmula de luminância relativa da WCAG. AA exige **4,5:1** para texto normal e
**3:1** para texto grande (≥ 24px, ou ≥ 18,66px em negrito) e elementos gráficos.

| Texto sobre fundo | Razão | Resultado |
|---|---|---|
| Branco sobre `#1D66B8` (azul escuro) | 5,76:1 | OK em qualquer tamanho |
| Branco sobre `#3391E0` (azul) | 3,35:1 | Só texto grande |
| Branco sobre `#1E9E00` (verde escuro) | 3,53:1 | Só texto grande |
| `#141414` sobre `#33FF00` (verde neon) | 13,55:1 | OK |
| `#141414` sobre `#FFC83D` (amarelo) | 11,91:1 | OK |
| `#141414` sobre `#DCEBFD` (azul claro) | 15,22:1 | OK |
| `#141414` sobre `#FFFFFF` | 18,42:1 | OK |
| `#141414` sobre `#3391E0` (azul) | 5,50:1 | OK |
| `#4A5868` sobre `#FFFFFF` | 7,27:1 | OK |
| `#4A5868` sobre `#DCEBFD` | 6,01:1 | OK |
| `#1D66B8` sobre `#FFFFFF` (link) | 5,76:1 | OK |
| `#1D66B8` sobre `#DCEBFD` (link) | 4,76:1 | OK |
| `#3391E0` sobre `#DCEBFD` | 2,77:1 | Reprovado para texto — só decoração |
| `#33FF00` sobre `#FFFFFF` | 1,36:1 | Reprovado — nunca texto verde neon em fundo claro |

Os valores informados na tarefa estavam corretos (diferenças só de arredondamento).

**Regra:** botões e textos pequenos usam **`--pc-azul-escuro` + branco** ou **`--pc-preto` sobre verde/amarelo**.
Branco sobre `--pc-azul` ou `--pc-verde-escuro` só em texto grande. Verde neon nunca é cor de texto sobre fundo claro.

## 5. Mascote Benchware

- Animado: `site/assets/img/benchware-wave.gif` (424×236, fundo transparente, 8 quadros).
- Parado: `site/assets/img/benchware.png` (primeiro quadro, transparente).
- Com `prefers-reduced-motion: reduce`, exibir o PNG (ex.: `<picture>` com
  `<source srcset="…/benchware.png" media="(prefers-reduced-motion: reduce)">`).
- `alt="Benchware, mascote do PCEDUC, acenando"`; quando decorativo e repetido, `alt=""`.
- Sempre informar `width` e `height` para evitar salto de layout.

### 5.1 Poses (DEC031, DEC032)

PNG transparentes 320×320 em `site/assets/img/mascote/` (fundo removido dos JPG do usuário; conferidas sobre
`#141414` e `#FFFFFF`). Nas seções, decorativas (`alt=""`, `width="320" height="320"`).

| Pose (`arquivo.png`) | Onde / quando |
|---|---|
| `acenando` | `#download` (cartão centralizado). No topo continua o GIF acenando |
| `sobrecarregado` | `#por-que` (cartão centralizado) |
| `jogando` | `#o-que-e` |
| `correndo` | `#como-funciona` |
| `construindo` | Ao lado da trilha (`#o-que-se-aprende`) |
| `trofeu` | Trilha com o balão do baú aberto (DEC034); quiz depois de acertar (DEC035) |
| `duvida` | `#experimente`, enquanto a pergunta está sem resposta |
| `errado` | `#experimente`, depois de errar |
| `formado` | `#para-quem` |
| `diploma` | `#equipe` |
| `erro-404` | `404.html` (com `alt` descritivo — texto aguardando aval, DEC036) |

- **Tamanho** (variável local `--pc-mascote-tamanho`, definida no escopo do componente em `mascote.css`, não é token
  global): seções `clamp(6.5rem, 30vw, 8rem)` → 8,75rem (≥ 600px) → 9,5rem (≥ 1280px); trilha
  `clamp(6.5rem, 28vw, 10.5rem)`; 404 `clamp(10rem, 45vw, 15rem)`.
- **Posição:** à direita do título (`.pc-secao__cabeca`) ou acima do título nos cartões centralizados (`.pc-mascote--centro`).
- Pose nova: PNG transparente 320×320, nome em `kebab-case` igual ao nome da pose, registrar nesta tabela.

## 6. Animações

- Leves e curtas (150–400ms): revelar cartões ao rolar (fade + subir 16px), hover com deslocamento da sombra.
- Nada piscando, nada em loop além do mascote (GIF do topo e flutuação das poses).
- **Mascote das seções (DEC033)**, em duas camadas (invólucro `.pc-mascote` + `.pc-mascote__img`):
  - entrada em **pulo** ao entrar na tela: 520ms, `cubic-bezier(0.34, 1.56, 0.64, 1)` (mola), de `translateY(1.5rem) scale(0.6)`
    a repouso;
  - **flutuação** contínua: sobe e desce 6px em 3,6s `ease-in-out`, fora de fase entre seções (`--pc-mascote-atraso`);
  - **troca de pose**: crossfade (a pose antiga some em 220ms) + pulinho da nova (350ms, sobe 10px e cresce até 1,06);
  - **hover** (só `@media (hover: hover)`): giro leve de 4° (lado alternado por `--pc-mascote-giro`), 250ms.
  - `--pc-mascote-tamanho`, `--pc-mascote-atraso` e `--pc-mascote-giro` são variáveis **locais do componente** (escopo
    `.pc-secao`/`.pc-mascote`/`.pc-trilha`/`.pc-erro__mascote`), não tokens da paleta.
- `@media (prefers-reduced-motion: reduce)`: desligar transições/animações, rolagem suave e o carrossel automático;
  cartões já aparecem visíveis; mascotes visíveis e parados, troca de pose instantânea.

### 6.1 Estados do mini quiz (DEC035) — sem cor nova

- **Correta:** fundo `--pc-verde`, texto `--pc-preto` (13,55:1), borda e sombra `--pc-verde-escuro`, ícone ✓, rótulo "Correta".
- **Errada:** a paleta não tem vermelho e **nenhum hex novo foi criado**: fundo `--pc-cinza` (`#4A5868`) com texto
  `--pc-branco` (7,27:1), contorno de 4px na cor do texto (`--pc-texto`), sem sombra e afundada, ícone ✕, rótulo
  "Sua resposta". Aqui o `#4A5868` é **fundo**, não texto (§9.3 continua valendo).
- Opções não escolhidas recuam com `opacity: 0.7` (texto ainda acima de 4,5:1).
- Feedback de acerto em `--pc-destaque-verde-texto`, fonte de título, 1,5rem.
- A cor nunca é o único sinal: sempre ícone + rótulo em texto.

## 7. Ícones

- Preferir emojis/ícones simples ou SVG inline com `aria-hidden="true"` e texto visível ao lado.
- v2: ícones do menu lateral e das abas em SVG inline próprio (sem Bootstrap Icons nem ícones do Duolingo — DEC013, DEC014).
- TODO(VIEW): se usar alguma biblioteca de ícones, registrar em `DECISOES.md`.

## 8. Tom de voz

- Simples, próximo e animado, como o pitch: "Aprenda hardware jogando", "passo a passo e sem complicação".
- Frases curtas; tratar o leitor por "você"; sem jargão sem explicação.
- Textos vêm só das fontes oficiais (RN002).

## 9. Tema escuro (v2)

Vale para a v2 do site (DEC013–DEC027). Os tokens de cor da §1 continuam existindo; os tokens abaixo dão
**papel** às cores no tema escuro. O view usa **estes nomes**.

### 9.1 Tokens novos (em `site/css/base.css`)

| Token | Valor | Uso |
|---|---|---|
| `--pc-fundo` | `var(--pc-preto)` (`#141414`) | Fundo da página |
| `--pc-superficie` | `var(--pc-preto)` (`#141414`) | Fundo de cartões, painel de missões, menu lateral, balões |
| `--pc-borda` | `var(--pc-cinza)` (`#4A5868`) | Bordas de 2px das superfícies, divisórias, decoração |
| `--pc-texto` | `var(--pc-branco)` (`#FFFFFF`) | Texto principal e títulos |
| `--pc-texto-suave` | `var(--pc-azul-claro)` (`#DCEBFD`) | Texto secundário, legendas, rótulos do menu |
| `--pc-azul-translucido` | `rgb(51 145 224 / 0.12)` (`#3391E0` a 12%) | Fundo do item ativo/hover do menu lateral e da aba ativa; rótulo azul ≈ 4,7:1 (DEC024) |
| `--pc-peso-titulo` | `400` | Peso de h1–h3 em Pixelify Sans (DEC021) |
| `--pc-raio` | `1rem` | Cartões, botões (v2; na v1 era `0.75rem`) |
| `--pc-raio-pequeno` | `0.5rem` | Selos, miniaturas, skip link (v2; na v1 era `0.375rem`) |
| `--pc-raio-total` | `999px` | Formas redondas/pílula (nós da trilha, abas, barras) |
| `--pc-contorno` | `2px solid var(--pc-borda)` (`#4A5868`) | Contorno das superfícies (v2; substitui o `3px solid #141414` da v1) |
| `--pc-profundidade` | `5px` | Altura da sombra sólida "3D" (`box-shadow: 0 var(--pc-profundidade) 0 <cor>`); ao pressionar, `translateY(var(--pc-profundidade))` |
| `--pc-transicao` | `180ms ease-out` | Transições leves |
| `--pc-foco` | `3px solid var(--pc-amarelo)` | Foco visível |
| `--pc-largura-centro` | `41.25rem` | Largura máxima da coluna central |
| `--pc-largura-painel` | `20rem` | Largura do painel de missões (desktop) |
| `--pc-altura-abas` | `4rem` | Altura da barra de abas inferior (reserva de espaço no mobile) |

Os tokens `--pc-sombra` e `--pc-sombra-hover` da v1 (§3) **não existem na v2**: a sombra sólida usa `--pc-profundidade` + cor.

Superfície = `background: var(--pc-superficie); border: var(--pc-contorno)` (2px `#4A5868`) `; border-radius: var(--pc-raio)`.

### 9.2 Destaques e botões

- **Destaques:** `--pc-azul` (`#3391E0`), `--pc-verde` (`#33FF00`), `--pc-amarelo` (`#FFC83D`) — todos passam como
  texto sobre `#141414` (tabela abaixo).
- **Botões principais:** `--pc-azul-escuro` (`#1D66B8`) com texto branco, **ou** `--pc-verde`/`--pc-amarelo`
  com texto `#141414`.
- **Botões redondos "3D"** (trilha de peças, DEC017): sombra sólida embaixo, sem desfoque, no tom mais escuro da
  própria paleta:
  - azul: fundo `--pc-azul` (`#3391E0`) + `box-shadow: 0 var(--pc-profundidade) 0 var(--pc-azul-escuro)` (`#1D66B8`);
  - verde: fundo `--pc-verde` (`#33FF00`) + `box-shadow: 0 var(--pc-profundidade) 0 var(--pc-verde-escuro)` (`#1E9E00`);
  - amarelo e azul-claro: sombra `--pc-cinza` (`#4A5868`) — **decisão provisória DEC026** (a paleta não tem amarelo escuro);
  - contorno/secundário: sombra `--pc-borda`;
  - ao pressionar (`:active`): `translateY(var(--pc-profundidade))` e sombra recolhida (sem transição com movimento reduzido).
  - Ícone/texto dentro do botão azul ou verde: `#141414` (5,50:1 e 13,55:1).
- **Barras das missões** (DEC016): preenchimento `--pc-amarelo`, trilho `--pc-borda`.
- **Faixa da seção atual** (DEC018): fundo azul; texto pequeno branco só sobre `--pc-azul-escuro`.
- **Foco visível:** continua `--pc-foco` (contorno amarelo `#FFC83D`, 11,91:1 sobre o fundo).

### 9.3 Restrições

- **`#4A5868` (`--pc-borda`) só em borda/decoração**, nunca como cor de texto: 2,53:1 sobre `#141414` (reprovado
  até para texto grande). Como também fica abaixo de 3:1 para componentes não textuais, a borda cinza não pode ser
  o **único** indicador de um controle ou estado: botões e links se identificam pelo texto/ícone ou por cor ≥ 3:1.
- `#1D66B8` sobre `#141414` dá 3,20:1: serve como **fundo de botão** (forma ≥ 3:1) com texto branco dentro, mas não
  como cor de texto pequeno sobre o fundo escuro.
- A sombra sólida `#141414` da v1 (`--pc-sombra`) some no fundo escuro. Sugestão para o view: na v2, sombra sólida
  dos cartões em `--pc-borda` (ex.: `0 4px 0 var(--pc-borda)`), mantendo a ideia de "sombra sólida sem desfoque".
- Amarelo não tem tom escuro na paleta: **resolvido provisoriamente por DEC026** — a sombra 3D de amarelo e
  azul-claro usa `--pc-cinza` (`#4A5868`). O usuário pode trocar; um hex novo só entra depois de aprovado e
  registrado na §1 (não inventar hex).
- Item ativo do menu/abas: fundo `--pc-azul-translucido` + rótulo `--pc-azul` (≈ 4,7:1, AA — DEC024).

### 9.4 Contraste no tema escuro (WCAG 2.1)

Calculado pela fórmula de luminância relativa da WCAG (`(L1 + 0,05) / (L2 + 0,05)`). AA: 4,5:1 texto normal;
3:1 texto grande (≥ 24px ou ≥ 18,66px em negrito) e elementos gráficos. AAA: 7:1.

| Cor sobre fundo | Razão | Resultado |
|---|---|---|
| `#FFFFFF` sobre `#141414` | 18,42:1 | OK (AAA) |
| `#DCEBFD` sobre `#141414` | 15,22:1 | OK (AAA) |
| `#3391E0` sobre `#141414` | 5,50:1 | OK (AA) |
| `#33FF00` sobre `#141414` | 13,55:1 | OK (AAA) |
| `#FFC83D` sobre `#141414` | 11,91:1 | OK (AAA) |
| `#1E9E00` sobre `#141414` | 5,22:1 | OK (AA) |
| `#4A5868` sobre `#141414` | 2,53:1 | **Reprovado** — só borda/decoração |
| `#141414` sobre `#33FF00` | 13,55:1 | OK (AAA) |
| `#141414` sobre `#FFC83D` | 11,91:1 | OK (AAA) |
| `#141414` sobre `#3391E0` | 5,50:1 | OK (AA) |
| `#FFFFFF` sobre `#1D66B8` | 5,76:1 | OK (AA) |
| `#1D66B8` sobre `#141414` (complementar) | 3,20:1 | Só texto grande / forma de botão |

## 10. Tema claro (DEC028–DEC030)

O tema escuro (§9) continua sendo a base. O claro vale quando o sistema pede (`prefers-color-scheme: light`) sem
escolha salva, ou quando o `<html>` tem `data-tema="claro"`. Definido em `site/css/base.css`.

### 10.1 Tokens que mudam no claro

| Token | Escuro | Claro |
|---|---|---|
| `--pc-fundo` | `#141414` | `#FFFFFF` |
| `--pc-superficie` | `#141414` | `#FFFFFF` |
| `--pc-borda` | `#4A5868` | `#4A5868` (mantido; no claro também serve de texto suave) |
| `--pc-texto` | `#FFFFFF` | `#141414` |
| `--pc-texto-suave` | `#DCEBFD` | `#4A5868` |
| `--pc-foco` | `3px solid` amarelo (`#FFC83D`) | `3px solid` azul-escuro (`#1D66B8`) — DEC030 |

### 10.2 Tokens semânticos novos

| Token | Escuro | Claro |
|---|---|---|
| `--pc-destaque-texto` | `--pc-azul` | `--pc-azul-escuro` |
| `--pc-destaque-verde-texto` | `--pc-verde` | `--pc-azul-escuro` |
| `--pc-destaque-amarelo-texto` | `--pc-amarelo` | `--pc-preto` |
| `--pc-link-hover` | `--pc-azul-claro` | `--pc-preto` |
| `--pc-ativo-fundo` | `--pc-azul-translucido` | `--pc-azul-claro` |
| `--pc-superficie-alt` | `--pc-preto` | `--pc-azul-claro` |
| `--pc-sombra-superficie` | `none` | `0 4px 0 var(--pc-borda)` |
| `--pc-anel-azul` / `--pc-anel-verde` / `--pc-anel-amarelo` | cor do nó (`--pc-azul` / `--pc-verde` / `--pc-amarelo`) | `--pc-azul-escuro` / `--pc-verde-escuro` / `--pc-cinza` |

**Regra:** nunca usar `--pc-verde`, `--pc-amarelo` ou `--pc-azul` direto como cor de **texto** — usar os tokens
`--pc-destaque-*`, que trocam de cor no tema claro. As cores da paleta continuam livres como fundo de botão/nó,
preenchimento e decoração.

### 10.3 Contraste no tema claro (WCAG 2.1)

| Cor sobre fundo | Razão | Resultado |
|---|---|---|
| `#141414` sobre `#FFFFFF` | 18,42:1 | OK (AAA) |
| `#4A5868` sobre `#FFFFFF` | 7,27:1 | OK (AAA) |
| `#1D66B8` sobre `#FFFFFF` | 5,76:1 | OK (AA) |
| `#1D66B8` sobre `#DCEBFD` | 4,76:1 | OK (AA) |
| `#141414` sobre `#DCEBFD` | 15,22:1 | OK (AAA) |
| `#4A5868` sobre `#DCEBFD` | 6,01:1 | OK (AA) |
| `#FFFFFF` sobre `#1D66B8` | 5,76:1 | OK (AA) |
| `#DCEBFD` sobre `#1D66B8` | 4,76:1 | OK (AA) |
| `#141414` sobre `#33FF00` / `#FFC83D` / `#3391E0` | 13,55:1 / 11,91:1 / 5,50:1 | OK (ícone/texto dentro de botões e nós) |
| `#1E9E00` sobre `#FFFFFF` | 3,53:1 | Só elemento gráfico / texto grande |
| `#3391E0` sobre `#FFFFFF` | 3,35:1 | Só elemento gráfico / texto grande |
| `#33FF00` sobre `#FFFFFF` | 1,36:1 | **Nunca texto** |
| `#FFC83D` sobre `#FFFFFF` | 1,55:1 | **Nunca texto** |

Nós e botões verde-neon/amarelo ficam abaixo de 3:1 sobre branco como forma; continuam identificáveis pelo ícone
preto (`#141414`, ≥ 11:1 dentro deles), pelo rótulo e pela sombra 3D/anel escuro (`--pc-anel-*`).
