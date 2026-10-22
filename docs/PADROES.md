# Padrões — Site demonstrativo do PCEDUC

Vale para a **v2** do site (HTML5, CSS3 e JavaScript puro, sem Bootstrap — DEC013). A v1 está no commit `be16dfc`.

## 1. Organização de `site/`

| Arquivo | Responsabilidade |
|---|---|
| `index.html` | Página única, HTML semântico, seções na ordem de DEC005 (+ `#experimente` — DEC035) |
| `404.html` | Página de erro servida pelo GitHub Pages para endereços inexistentes; caminhos absolutos (DEC036) |
| `css/base.css` | Tokens `--pc-*` (inclusive os do tema escuro: `--pc-fundo`, `--pc-superficie`, `--pc-borda`, `--pc-texto`, `--pc-texto-suave`, `--pc-azul-translucido`, `--pc-peso-titulo`…), tokens semânticos `--pc-destaque-*`, `--pc-anel-*` etc. e os valores do tema claro (`prefers-color-scheme` + `data-tema` — DEC028, `IDENTIDADE_VISUAL.md` §10), reset leve, tipografia, foco, `prefers-reduced-motion` |
| `css/layout.css` | Estrutura da página: cabeçalho/menu lateral fixo (só ícones em 1024–1279px, rótulos a partir de 1280px), 3 colunas (≥ 1024px), faixa da seção atual (só desktop), painel "Missões do PCEDUC", barra de abas inferior (< 1024px) — DEC016, DEC018, DEC023, DEC024 |
| `css/components.css` | Componentes `pc-*`: cartões, botões "3D", selos de ícone, equipe, download, rodapé, revelar ao rolar |
| `css/galeria.css` | Galeria "Telas do app": faixa com `scroll-snap` (vale sem JS), carrossel com "coverflow" leve, controles, indicadores e o reservado "Tela em breve" (DEC038, RN003). Carregado depois de `components.css` (usa `.pc-btn`) |
| `css/trilha.css` | Trilha em zigue-zague de "O que se aprende": nós 3D, baú da peça rara (botão — DEC034), balões, divisor (DEC017) |
| `css/mascote.css` | Mascote Benchware nas seções: tamanho, cabeçalho com mascote (`.pc-secao__cabeca`), mascote da trilha (DEC027), animações de entrada, flutuação, troca de pose e giro (DEC033). Usado no `index.html` e na `404.html` |
| `css/quiz.css` | Mini quiz "Experimente": cartão, `<details>` sem JS, opções 3D, estados de acerto/erro, feedback (DEC035). Só no `index.html` |
| `css/erro.css` | Layout da página 404 (cabeçalho com logo, bloco central). **Só na `404.html`** (DEC036) |
| `js/main.js` | Comportamentos: botão de tema (`configurarTema`), links de download, carrossel da galeria (`montarGaleria`, lê as telas do HTML), destaque da seção visível (menu/abas/faixa), barras das missões, balões da trilha (com troca de pose no baú — `atualizarMascote`), mascotes (`configurarMascotes`, `trocarPose`, `preCarregarPoses`), mini quiz (`configurarQuiz`), revelar ao rolar. Não é carregado na `404.html` |
| `assets/img/` | Mascote do topo (GIF e quadro parado) e imagens fixas |
| `assets/img/mascote/` | 11 poses do Benchware, PNG transparentes 320×320, nome = pose (`duvida.png`, `trofeu.png`…) — DEC031 |
| `assets/telas/` | Telas reais do app, PNG 540×1080 com a moldura do iPhone embutida (`tela-01.png`…`tela-04.png` — DEC038); instruções em `assets/telas/README.md` |

- Uma responsabilidade por arquivo.
- **Limite: cada arquivo CSS com menos de 600 linhas** (DEC020). Passou disso, dividir por componente
  (como já foi feito com `css/trilha.css`) e registrar aqui e em `PROJETO.md`.
- Nada de CSS inline nem `<script>` inline (exceto JSON-LD, se houver).
  **Exceção (DEC029):** o script mínimo de tema no `<head>`, antes dos CSS, que só lê `localStorage['pc-tema']`
  e aplica `data-tema` para não piscar no tema errado. Não acrescentar outra lógica nele.
- Caminhos **relativos** (`css/base.css`, `assets/img/...`) — o Pages publica em `/<repositorio>/`, então `/css/...` quebra.
  **Exceção (DEC036):** a `404.html` usa caminhos absolutos com o prefixo `/Projeto-Extensao-PCEDUC/`, porque o Pages
  a serve em qualquer subcaminho. Se o repositório mudar de nome ou ganhar domínio próprio, trocar o prefixo.
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
7. `css/galeria.css` (depois de `components.css`: usa `.pc-btn`)
8. `css/trilha.css`
9. `css/mascote.css` (depois de `trilha.css`: posiciona o mascote da trilha)
10. `css/quiz.css`
11. `<script src="js/main.js" defer></script>`

Na `404.html`: script inline de tema → `css/base.css` → `css/components.css` → `css/mascote.css` → `css/erro.css`
(sem `layout.css` e sem `main.js`: o mascote fica no lugar, só com a flutuação do CSS).

No `main.js`, `configurarQuiz` e `configurarMascotes` rodam **depois** de `configurarTrilha` (o mascote da trilha só
fica visível — e observável — quando a trilha já está interativa).

## 3. Nomenclatura de classes

- Classes com prefixo **`pc-`** e **BEM leve**: `pc-bloco`, `pc-bloco__elemento`, `pc-bloco--variacao`.
  Ex.: `pc-card`, `pc-card__titulo`, `pc-lateral__link`, `pc-abas__link`, `pc-trilha__mascote`, `pc-missao__titulo`,
  `pc-btn--verde`.
- Classes de estado (adicionadas pelo JS):
  - `js` no `<html>` — o JS rodou (os balões da trilha passam a ficar fechados);
  - `pc-revelar-ativo` no `<html>` — revelar ao rolar ligado; `is-visivel` no cartão `.pc-revelar` que entrou na tela;
  - `pc-trilha--interativa` na trilha — balões interativos e mascote visível (DEC027);
  - `is-aberto` no balão aberto;
  - `pc-mascote-ativo` no `<html>` — entrada dos mascotes ligada (há `IntersectionObserver` e movimento permitido);
    `is-visivel` no `.pc-mascote` que entrou na tela (DEC033);
  - `is-trocando` na `.pc-mascote__img` durante a troca de pose; `.pc-mascote__fantasma` é a cópia temporária da
    pose antiga, removida ao fim da animação;
  - `data-pc-estado` no quiz: `"correta"`/`"errada"` na opção e `"acerto"`/`"erro"` no feedback (DEC035);
  - `pc-tema-trocando` no `<html>` — posta por ~400ms ao trocar de tema, liga a transição de cores (desligada com
    movimento reduzido);
  - `pc-galeria--carrossel` na `.pc-galeria` — o JS montou o carrossel (controles, "coverflow", trilho sem barra);
    sem ela, as telas ficam lado a lado/faixa rolável; `is-atual` no `.pc-galeria__slide` da tela atual (DEC038).
- Atributo de tema: `data-tema="claro"|"escuro"` no `<html>` (script inline ou `main.js`); sem ele, vale o sistema (DEC028).
  - Item ativo do menu/aba e indicador do carrossel: **só `aria-current="true"`** (não existe `is-ativo`).
    Download desativado: `aria-disabled="true"` (não existe `is-desativado`).
- Ganchos de JS: atributos `data-pc-*` (ex.: `data-pc-download`, `data-pc-download-selo`, `data-pc-barra`,
  `data-pc-faixa-numero`, `data-pc-faixa-nome`, `data-pc-grupo` nas abas — DEC025; `data-pc-tema` no botão de tema,
  `data-pc-tema-icone` no `<use>` do ícone sol/lua e `data-pc-tema-rotulo` no rótulo — DEC028; `data-pc-mascote-trilha` na
  imagem do mascote da trilha — DEC034; quiz: `data-pc-quiz` (cartão), `data-pc-quiz-estatico` (`<details>` sem JS),
  `data-pc-quiz-interativo`, `data-pc-quiz-opcao` (`="correta"` na certa), `data-pc-quiz-status`, `data-pc-quiz-feedback`,
  `data-pc-quiz-tentar` e `data-pc-quiz-mascote` — DEC035; galeria: `data-pc-galeria` (contêiner) e
  `data-pc-galeria-trilho` (faixa com os slides) — DEC038).
- IDs só para âncoras de seção (`#topo`, `#por-que`, `#o-que-e`, `#como-funciona`, `#missoes`, `#o-que-se-aprende`,
  `#experimente`, `#para-quem`, `#telas`, `#equipe`, `#download`; skip link → `#conteudo`), para o sprite de ícones
  (`#i-*`, inclusive `#i-experimente`, `#i-certo`, `#i-errado`) e para ligar ARIA (`aria-controls` →
  `#pc-balao-1`…`#pc-balao-6` e `#pc-balao-bau`; `aria-labelledby` → `#titulo-*` e `#pc-quiz-pergunta` no grupo de
  opções do quiz).

## 4. JavaScript

- JS puro, sem jQuery nem bibliotecas; `"use strict"`; carregado com `defer`; tudo em funções pequenas.
- Dado editável no topo do `main.js`: objeto `LINKS_DOWNLOAD` (DEC008). As telas da galeria ficam no HTML
  (`figure.pc-galeria__slide` na seção `#telas`) e o JS só as lê do DOM (DEC007, DEC038).
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

- `<html lang="pt-BR">`; landmarks: `<header>` com `<nav aria-label="Seções">` (menu lateral, 10 itens — inclui "Experimente", DEC035),
  `<main id="conteudo">`, `<aside id="missoes" aria-labelledby="titulo-missoes">` ("Missões do PCEDUC", dentro do `<main>`),
  `<footer>` e `<nav aria-label="Atalhos">` (barra de abas inferior, 5 abas — DEC025).
- **Skip link** como primeiro elemento focável: "Pular para o conteúdo" → `#conteudo`.
- Um único `<h1>`; hierarquia de títulos sem pular níveis; cada `<section>` com `aria-labelledby` no seu título.
- Toda imagem com `alt` útil (decorativa: `alt=""`); `width`/`height` informados. Ícones SVG com `aria-hidden="true"` e rótulo visível.
- **Foco visível** em tudo que é interativo (`:focus-visible` com `--pc-foco`); nunca `outline: none` sem substituto.
- Contraste conforme `IDENTIDADE_VISUAL.md` §9 (tema escuro); `#4A5868` nunca como texto.
- Item do menu/aba da seção visível com `aria-current="true"`.
- Peças da trilha e baú: `<button>` com `aria-expanded`/`aria-controls`; balão fecha com Esc e devolve o foco à peça.
- Quiz: opções são `<button>` num `role="group"` rotulado pela pergunta; acerto/erro nunca só pela cor (ícone ✓/✕ +
  rótulo "Correta"/"Sua resposta"); feedback em `aria-live="polite"`; depois de responder, o foco vai para "Tentar de novo".
- Mascotes das seções são decorativos (`alt=""`); com `prefers-reduced-motion` ficam parados (DEC033).
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
