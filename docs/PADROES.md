# Padrões — Site demonstrativo do PCEDUC

Vale para a **v2** do site (HTML5, CSS3 e JavaScript puro, sem Bootstrap — DEC013). A v1 está no commit `0fc3109`.

## 1. Organização de `site/`

| Arquivo | Responsabilidade |
|---|---|
| `index.html` | Página única, HTML semântico, seções na ordem de DEC005 |
| `css/base.css` | Tokens `--pc-*` (inclusive os do tema escuro: `--pc-fundo`, `--pc-superficie`, `--pc-borda`, `--pc-texto`, `--pc-texto-suave`, `--pc-azul-translucido`, `--pc-peso-titulo`…), tokens semânticos `--pc-destaque-*`, `--pc-anel-*` etc. e os valores do tema claro (`prefers-color-scheme` + `data-tema` — DEC028, `IDENTIDADE_VISUAL.md` §10), reset leve, tipografia, foco, `prefers-reduced-motion` |
| `css/layout.css` | Estrutura da página: cabeçalho/menu lateral fixo (só ícones em 1024–1279px, rótulos a partir de 1280px), 3 colunas (≥ 1024px), faixa da seção atual (só desktop), painel "Missões do PCEDUC", barra de abas inferior (< 1024px) — DEC016, DEC018, DEC023, DEC024 |
| `css/components.css` | Componentes `pc-*`: cartões, botões "3D", selos de ícone, galeria/carrossel, equipe, download, rodapé, revelar ao rolar |
| `css/trilha.css` | Trilha em zigue-zague de "O que se aprende": nós 3D, baú da peça rara, balões, divisor, mascote da trilha (DEC017, DEC027) |
| `js/main.js` | Comportamentos: botão de tema (`configurarTema`), links de download, lista de telas e carrossel, destaque da seção visível (menu/abas/faixa), barras das missões, balões da trilha, revelar ao rolar |
| `assets/img/` | Mascote e imagens fixas |
| `assets/telas/` | Telas exportadas do Figma (`tela-01.png`, `tela-02.png`…) |

- Uma responsabilidade por arquivo.
- **Limite: cada arquivo CSS com menos de 600 linhas** (DEC020). Passou disso, dividir por componente
  (como já foi feito com `css/trilha.css`) e registrar aqui e em `PROJETO.md`.
- Nada de CSS inline nem `<script>` inline (exceto JSON-LD, se houver).
  **Exceção (DEC029):** o script mínimo de tema no `<head>`, antes dos CSS, que só lê `localStorage['pc-tema']`
  e aplica `data-tema` para não piscar no tema errado. Não acrescentar outra lógica nele.
- Caminhos **relativos** (`css/base.css`, `assets/img/...`) — o Pages publica em `/<repositorio>/`, então `/css/...` quebra.
- Nomes de arquivos em `kebab-case`; imagens com nome descritivo.
- Sem bibliotecas externas de CSS/JS (DEC013). Única dependência externa: Google Fonts.

## 2. Ordem de carregamento

No `<head>`:
1. `meta charset`, `viewport`, `title`, `description`, Open Graph
2. `preconnect` + Google Fonts (`display=swap`; Chakra Petch 400/600/700 e Pixelify Sans **só 400** — DEC021)
3. `<script>` inline de tema (DEC029) — sempre **antes** dos CSS
4. `css/base.css`
5. `css/layout.css`
6. `css/components.css`
7. `css/trilha.css`
8. `<script src="js/main.js" defer></script>`

## 3. Nomenclatura de classes

- Classes com prefixo **`pc-`** e **BEM leve**: `pc-bloco`, `pc-bloco__elemento`, `pc-bloco--variacao`.
  Ex.: `pc-card`, `pc-card__titulo`, `pc-lateral__link`, `pc-abas__link`, `pc-trilha__mascote`, `pc-missao__titulo`,
  `pc-btn--verde`.
- Classes de estado (adicionadas pelo JS):
  - `js` no `<html>` — o JS rodou (os balões da trilha passam a ficar fechados);
  - `pc-revelar-ativo` no `<html>` — revelar ao rolar ligado; `is-visivel` no cartão `.pc-revelar` que entrou na tela;
  - `pc-trilha--interativa` na trilha — balões interativos e mascote visível (DEC027);
  - `is-aberto` no balão aberto;
  - `pc-tema-trocando` no `<html>` — posta por ~400ms ao trocar de tema, liga a transição de cores (desligada com
    movimento reduzido).
- Atributo de tema: `data-tema="claro"|"escuro"` no `<html>` (script inline ou `main.js`); sem ele, vale o sistema (DEC028).
  - Item ativo do menu/aba e indicador do carrossel: **só `aria-current="true"`** (não existe `is-ativo`).
    Download desativado: `aria-disabled="true"` (não existe `is-desativado`).
- Ganchos de JS: atributos `data-pc-*` (ex.: `data-pc-download`, `data-pc-download-selo`, `data-pc-barra`,
  `data-pc-faixa-numero`, `data-pc-faixa-nome`, `data-pc-grupo` nas abas — DEC025; `data-pc-tema` no botão de tema,
  `data-pc-tema-icone` no `<use>` do ícone sol/lua e `data-pc-tema-rotulo` no rótulo — DEC028).
- IDs só para âncoras de seção (`#topo`, `#por-que`, `#o-que-e`, `#como-funciona`, `#missoes`, `#o-que-se-aprende`,
  `#para-quem`, `#telas`, `#equipe`, `#download`; skip link → `#conteudo`), para o sprite de ícones (`#i-*`) e
  para ligar ARIA (`aria-controls` → `#pc-balao-1`…`#pc-balao-6`; `aria-labelledby` → `#titulo-*`).

## 4. JavaScript

- JS puro, sem jQuery nem bibliotecas; `"use strict"`; carregado com `defer`; tudo em funções pequenas.
- Dados editáveis no topo do `main.js`: objeto `LINKS_DOWNLOAD` e array `TELAS` (DEC007, DEC008).
- Detectar `prefers-reduced-motion` com `matchMedia` antes de animar (carrossel sem autoplay, barras sem transição).
- `IntersectionObserver` para a seção visível e para revelar cartões; sem suporte, tudo continua visível e navegável.
- Sem `innerHTML` com texto vindo de fora; preferir `textContent` / `createElement`.
- O conteúdo não depende do JS: sem JS, as descrições das peças e as missões ficam visíveis.
- `localStorage` **só** para a preferência de tema (chave `'pc-tema'`, valores `'claro'`/`'escuro'` — DEC028), e
  sempre dentro de `try/catch` (pode estar bloqueado em modo privado ou por política do navegador).

## 5. Política de comentários

Comentário explica **por quê**, não **o quê**.

| Onde | Como |
|---|---|
| Início de cada arquivo | Cabeçalho de 2–3 linhas: para que serve |
| Seções de CSS/HTML longos | `/* ===== Galeria ===== */` · `<!-- ===== Galeria ===== -->` |
| Regra de negócio | `// RN001: botão desativado enquanto o link estiver vazio` |
| Decisão não óbvia | `/* DEC016: abaixo de 1024px o painel de missões vira seção normal */` |
| Pendência | `// TODO(VIEW): ...` · `TODO(DOCUMENT)` |

Não comentar o óbvio, não deixar código morto comentado (o Git guarda), atualizar ou remover comentário desatualizado.

## 6. Acessibilidade (obrigatório)

- `<html lang="pt-BR">`; landmarks: `<header>` com `<nav aria-label="Seções">` (menu lateral, 9 seções),
  `<main id="conteudo">`, `<aside id="missoes" aria-labelledby="titulo-missoes">` ("Missões do PCEDUC", dentro do `<main>`),
  `<footer>` e `<nav aria-label="Atalhos">` (barra de abas inferior, 5 abas — DEC025).
- **Skip link** como primeiro elemento focável: "Pular para o conteúdo" → `#conteudo`.
- Um único `<h1>`; hierarquia de títulos sem pular níveis; cada `<section>` com `aria-labelledby` no seu título.
- Toda imagem com `alt` útil (decorativa: `alt=""`); `width`/`height` informados. Ícones SVG com `aria-hidden="true"` e rótulo visível.
- **Foco visível** em tudo que é interativo (`:focus-visible` com `--pc-foco`); nunca `outline: none` sem substituto.
- Contraste conforme `IDENTIDADE_VISUAL.md` §9 (tema escuro); `#4A5868` nunca como texto.
- Item do menu/aba da seção visível com `aria-current="true"`.
- Peças da trilha: `<button>` com `aria-expanded`/`aria-controls`; balão fecha com Esc e devolve o foco à peça.
- Carrossel: botões anterior/próximo rotulados, indicadores com `aria-label`, setas do teclado, sem autoplay com
  `prefers-reduced-motion`; slide atual anunciado (`aria-live="polite"` quando trocado pelo usuário).
- Botões de download desativados: `aria-disabled="true"`, `tabindex="-1"`, sem `href`, com texto "Em breve" visível.
- Links externos (Figma, GitHub): `rel="noopener"` e indicar que abrem em nova aba quando usar `target="_blank"`.
- Navegável só pelo teclado; alvos de toque com pelo menos 44×44px; a barra de abas inferior não pode cobrir
  conteúdo (reservar `padding-bottom` no `<main>` e `scroll-padding`).

## 7. Git

- Branch de trabalho atual: `Pedrovini`; publicação a partir da `master` (DEC002).
- Conventional Commits: `feat(view): ...`, `docs: ...`, `chore: ...`, `ci: ...`.
- `.claude/` e `CLAUDE.md` nunca entram neste repositório (DEC012).
- Nada de `push --force` ou `reset --hard` sem confirmação.
