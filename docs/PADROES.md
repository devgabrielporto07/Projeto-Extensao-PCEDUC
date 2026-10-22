# Padrões — Site demonstrativo do PCEDUC

## 1. Organização de `site/`

| Arquivo | Responsabilidade |
|---|---|
| `index.html` | Página única, HTML semântico, seções na ordem de DEC005 |
| `css/base.css` | Tokens `--pc-*`, overrides das variáveis do Bootstrap (`--bs-*`), reset leve, tipografia, foco, `prefers-reduced-motion` |
| `css/components.css` | Componentes `pc-*` (navbar, hero, cartões, trilha, galeria, equipe, download, rodapé) |
| `js/main.js` | Comportamentos: links de download, lista de telas da galeria, revelar ao rolar, ajustes de menu |
| `assets/img/` | Mascote e imagens fixas |
| `assets/telas/` | Telas exportadas do Figma (`tela-01.png`, `tela-02.png`…) |

- Uma responsabilidade por arquivo. Se `components.css` passar de ~600 linhas, dividir em `css/components/<nome>.css`.
- Nada de CSS inline nem `<script>` inline (exceto JSON-LD, se houver).
- Caminhos **relativos** (`css/base.css`, `assets/img/...`) — o Pages publica em `/<repositorio>/`, então `/css/...` quebra.
- Nomes de arquivos em `kebab-case`; imagens com nome descritivo.

## 2. Ordem de carregamento

No `<head>`:
1. `meta charset`, `viewport`, `title`, `description`, Open Graph
2. `preconnect` + Google Fonts (`display=swap`)
3. Bootstrap CSS (CDN com `integrity`, DEC003)
4. `css/base.css`
5. `css/components.css`

No `<head>` com `defer` (ou fim do `<body>`):
6. `bootstrap.bundle.min.js` (CDN com `integrity`)
7. `js/main.js`

## 3. Nomenclatura de classes

- Classes próprias com prefixo **`pc-`** e **BEM leve**: `pc-bloco`, `pc-bloco__elemento`, `pc-bloco--variacao`.
  Ex.: `pc-card`, `pc-card__titulo`, `pc-card--destaque`, `pc-download__botao`.
- Classes do Bootstrap (`container`, `row`, `col-md-4`, `navbar`, `carousel`) podem ser usadas junto.
- Não sobrescrever classes do Bootstrap diretamente (ex.: `.card { }`); criar a classe `pc-` ou usar as variáveis `--bs-*`.
- Estados: `is-visivel`, `is-desativado`; ganchos de JS: atributos `data-pc-*` (ex.: `data-pc-download="android"`).
- IDs só para âncoras de seção (`#por-que`, `#o-que-e`, `#como-funciona`, `#o-que-se-aprende`,
  `#para-quem`, `#galeria`, `#equipe`, `#download`).

## 4. JavaScript

- JS puro, sem jQuery; `"use strict"`; tudo em funções pequenas chamadas no `DOMContentLoaded` (ou com `defer`).
- Dados editáveis no topo do `main.js`: objeto `LINKS_DOWNLOAD` e array `TELAS` (DEC007, DEC008).
- Detectar `prefers-reduced-motion` com `matchMedia` antes de animar.
- Sem `innerHTML` com texto vindo de fora; preferir `textContent` / `createElement`.

## 5. Política de comentários

Comentário explica **por quê**, não **o quê**.

| Onde | Como |
|---|---|
| Início de cada arquivo | Cabeçalho de 2–3 linhas: para que serve |
| Seções de CSS/HTML longos | `/* ===== Galeria ===== */` · `<!-- ===== Galeria ===== -->` |
| Regra de negócio | `// RN001: botão desativado enquanto o link estiver vazio` |
| Decisão não óbvia | `/* DEC004: --bs-primary recebe o azul escuro por contraste */` |
| Pendência | `// TODO(VIEW): ...` · `TODO(DOCUMENT)` |

Não comentar o óbvio, não deixar código morto comentado (o Git guarda), atualizar ou remover comentário desatualizado.

## 6. Acessibilidade (obrigatório)

- `<html lang="pt-BR">`; landmarks: `<header>`, `<nav aria-label="Principal">`, `<main id="conteudo">`, `<footer>`.
- **Skip link** como primeiro elemento focável: "Pular para o conteúdo" → `#conteudo`.
- Um único `<h1>`; hierarquia de títulos sem pular níveis; cada `<section>` com `aria-labelledby` no seu título.
- Toda imagem com `alt` útil (decorativa: `alt=""`); `width`/`height` informados.
- **Foco visível** em tudo que é interativo (`:focus-visible` com `--pc-foco`); nunca `outline: none` sem substituto.
- Contraste conforme `IDENTIDADE_VISUAL.md` §4.
- Botão de menu com `aria-controls`/`aria-expanded` (o collapse do Bootstrap já cuida); carrossel com controles
  rotulados, indicadores com `aria-label` e sem autoplay quando `prefers-reduced-motion`.
- Botões de download desativados: `aria-disabled="true"`, `tabindex="-1"`, sem `href`, com texto "Em breve" visível.
- Links externos (Figma, GitHub): `rel="noopener"` e indicar que abrem em nova aba quando usar `target="_blank"`.
- Navegável só pelo teclado; alvos de toque com pelo menos 44×44px.

## 7. Git

- Branch de trabalho atual: `Pedrovini`; publicação a partir da `master` (DEC002).
- Conventional Commits: `feat(view): ...`, `docs: ...`, `chore: ...`, `ci: ...`.
- `.claude/` e `CLAUDE.md` nunca entram neste repositório (DEC012).
- Nada de `push --force` ou `reset --hard` sem confirmação.
