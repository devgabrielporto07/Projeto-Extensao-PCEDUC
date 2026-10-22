# Identidade visual — PCEDUC

Visual lúdico de "jogo retrô": tipografia pixelada nos títulos, contornos escuros, sombras sólidas,
azul como cor principal, verde neon para XP e amarelo para conquistas. Mascote: **Benchware**.

## 1. Paleta e tokens CSS

Definidos em `site/css/base.css`, dentro de `:root`. Use **sempre o token**, nunca o hex solto.

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

Overrides do Bootstrap (em `base.css`, DEC004):

| Variável do Bootstrap | Recebe |
|---|---|
| `--bs-primary` / `--bs-primary-rgb` | `--pc-azul-escuro` / `29, 102, 184` |
| `--bs-success` / `--bs-success-rgb` | `--pc-verde-escuro` / `30, 158, 0` |
| `--bs-warning` / `--bs-warning-rgb` | `--pc-amarelo` / `255, 200, 61` |
| `--bs-body-color` | `--pc-preto` |
| `--bs-body-bg` | `--pc-branco` |
| `--bs-secondary-color` | `--pc-cinza` |
| `--bs-link-color` / `--bs-link-hover-color` | `--pc-azul-escuro` / `--pc-preto` |
| `--bs-border-color` | `--pc-preto` |
| `--bs-body-font-family` | `--pc-fonte-texto` |
| `--bs-border-radius` | `--pc-raio` |

Botões `.btn-primary` do Bootstrap 5.3 usam variáveis próprias (`--bs-btn-bg` etc.): sobrescreva-as
na classe com os tokens acima.

## 2. Tipografia

| Token | Valor | Uso |
|---|---|---|
| `--pc-fonte-titulo` | `"Pixelify Sans", "Courier New", monospace` | h1–h3, números de XP, selos |
| `--pc-fonte-texto` | `"Chakra Petch", "Segoe UI", system-ui, sans-serif` | Textos, botões, menu |

- Google Fonts com `display=swap` e `preconnect` para `fonts.googleapis.com` e `fonts.gstatic.com`.
  Pesos sugeridos: Pixelify Sans 400/700; Chakra Petch 400/600/700.
- Tamanhos com `clamp()` (fluido); texto de corpo mínimo 1rem; Pixelify Sans só em títulos (é menos legível em blocos).

## 3. Espaçamentos, raios, contornos e sombras

| Token | Valor | Uso |
|---|---|---|
| `--pc-espaco-1` … `--pc-espaco-6` | `0.25rem`, `0.5rem`, `1rem`, `1.5rem`, `2.5rem`, `4rem` | Margens e paddings (ou utilitários do Bootstrap) |
| `--pc-raio` | `0.75rem` | Cartões, botões |
| `--pc-raio-pequeno` | `0.375rem` | Selos, miniaturas |
| `--pc-contorno` | `3px solid var(--pc-preto)` | Cartões, botões, molduras (2px em telas pequenas) |
| `--pc-sombra` | `4px 4px 0 var(--pc-preto)` | Sombra sólida, sem desfoque |
| `--pc-sombra-hover` | `6px 6px 0 var(--pc-preto)` | Hover/foco de cartões e botões |
| `--pc-foco` | `3px solid var(--pc-amarelo)` + `outline-offset: 3px` | Foco visível (`:focus-visible`) |
| `--pc-transicao` | `180ms ease-out` | Transições leves |

**Cartões:** fundo branco, `--pc-contorno`, `--pc-sombra`, `--pc-raio`. Hover: `translate(-2px, -2px)` + `--pc-sombra-hover`.

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

## 6. Animações

- Leves e curtas (150–400ms): revelar cartões ao rolar (fade + subir 16px), hover com deslocamento da sombra.
- Nada piscando, nada em loop além do mascote.
- `@media (prefers-reduced-motion: reduce)`: desligar transições/animações, rolagem suave e o carrossel automático;
  cartões já aparecem visíveis.

## 7. Ícones

- Preferir emojis/ícones simples ou SVG inline com `aria-hidden="true"` e texto visível ao lado.
- TODO(VIEW): se usar biblioteca de ícones (ex.: Bootstrap Icons via CDN), registrar em `DECISOES.md`.

## 8. Tom de voz

- Simples, próximo e animado, como o pitch: "Aprenda hardware jogando", "passo a passo e sem complicação".
- Frases curtas; tratar o leitor por "você"; sem jargão sem explicação.
- Textos vêm só das fontes oficiais (RN002).
