# Funcionalidades — Site demonstrativo do PCEDUC (v2)

Status: `planejada` · `em andamento` · `pronta`. Fontes: **README** (`README.md`), **PITCH** (`Pitch/PC educ.pdf`),
**REQ** (`Documentação/.../PCEDUC-Proposito-e-Requisitos.pdf`). "PC educ" do pitch vira "PCEDUC" (DEC006).
Os textos abaixo são a base; o agente view pode encurtar, mas não inventar conteúdo (RN002).

**v2** (DEC013–DEC027): estilo de trilha gamificada inspirado na tela da trilha do Duolingo web (DEC014), tema
escuro, sem Bootstrap. A v1 (Bootstrap, tema claro) fica no commit `0fc3109`. O conteúdo das seções não mudou.

## Seções da página (ordem — DEC005)

| ID | Seção (âncora) | Status | Conteúdo | Fonte |
|---|---|---|---|---|
| F001 | Topo / hero (`#topo`, `<h1>`) | pronta | Mascote Benchware; "PCEDUC"; slogan "Aprenda hardware jogando: trilhas, pontos e conquistas."; "Projeto de extensão da UNINASSAU Campina Grande — Ciência da Computação"; botões "Baixar o app" (→ `#download`) e "Conheça o protótipo" (Figma) | README |
| F002 | Por que ensinar hardware? (`#por-que`) | pronta | "Usamos computadores todos os dias, mas poucos sabem como eles funcionam por dentro." / "O PCEDUC transforma essa curiosidade em aprendizado, passo a passo e sem complicação." | PITCH |
| F003 | O que é o PCEDUC? (`#o-que-e`) | pronta | "Um app que ensina jogando": aplicativo no estilo do Duolingo, conteúdo dividido em trilhas, cada lição concluída rende pontos e conquistas. "Foco em hardware": explica o que cada componente faz e como funciona, de forma simples e visual. | PITCH + README |
| F004 | Como funciona → **painel "Missões do PCEDUC"** (`#como-funciona`) | pronta | Os 4 passos viram missões, cada uma com barra amarela (F019): **Trilhas de aprendizado** (lições em sequência, cada trilha leva um passo adiante); **Pontuação / XP** (cada lição concluída soma pontos e mostra o progresso; XP define o nível); **Conquistas** (medalhas e marcos recompensam a dedicação); **Peças colecionáveis** (ao concluir trilhas ou metas de XP, ganha peças virtuais que montam um PC completo no perfil; às vezes uma peça rara-surpresa). Desktop: painel direito fixo (`<aside id="missoes">`); < 1024px: o painel aparece no fluxo logo após `#como-funciona` (DEC016). Sem cartão de mini status XP/Nível/Peças (DEC022) | PITCH + REQ §3 + README |
| F005 | O que se aprende → **trilha de peças** (`#o-que-se-aprende`) | pronta | Trilha em zigue-zague com 6 botões redondos "3D", Benchware ao lado e baú de peça rara no fim; clicar abre balão com a descrição (F020, DEC017): Placa-mãe — "Conecta e integra todos os componentes."; Processador — "O cérebro que executa as instruções."; Placa de vídeo — "Gera as imagens exibidas na tela."; Memória RAM — "Guarda os dados em uso no momento."; Armazenamento — "Mantém arquivos e programas salvos."; Fonte de energia — "Fornece energia a cada peça." Fecho: "E muito mais, trilha após trilha." | PITCH |
| F006 | Para quem é (`#para-quem`) | pronta | "Voltado ao ensino médio": foco nos adolescentes; crianças e adultos também aprendem no seu ritmo. Cartões: **Crianças** (etapas curtas e visual divertido…), **Adolescentes** (estudantes do ensino médio: desafios e pontuação despertam a curiosidade por tecnologia), **Adultos** (forma prática de entender o computador do dia a dia) | PITCH |
| F007 | Galeria de telas (`#telas`) | pronta (aguardando conteúdo) | Carrossel em JS puro (F014) com as telas do app (`site/assets/telas/tela-XX.png`); reservado "Tela em breve" quando faltar a imagem (RN003); link "Ver o protótipo completo no Figma". Aguarda os PNGs exportados do Figma. | Figma (DEC007, DEC019) |
| F008 | Equipe (`#equipe`) | pronta | 7 integrantes com nome e link do GitHub, conforme a tabela do README (RN004) | README |
| F009 | Download (`#download`) | pronta (aguardando conteúdo) | "Baixar o app": botões **Windows** e **Android**; desativados com selo "Em breve" enquanto não houver link (RN001). Aguarda os links dos instaladores | Decisão do usuário (DEC008, DEC010) |
| F010 | Rodapé | pronta | "Aprender hardware pode ser divertido."; PCEDUC — Projeto de Extensão, UNINASSAU Campina Grande; licença Apache 2.0; links para o repositório e para abrir issue | PITCH + README |

## Comportamentos

| ID | Comportamento | Status | Detalhe |
|---|---|---|---|
| F011 | Navegação: menu lateral (desktop) e abas inferiores (mobile) | pronta | **≥ 1024px:** menu lateral fixo à esquerda, ícone SVG + rótulo para cada seção. **< 1024px:** barra de abas inferior fixa com **Início** (`#topo`), **Aprender** (`#o-que-se-aprende`), **Telas** (`#telas`), **Equipe** (`#equipe`), **Baixar** (`#download`), como no wireframe do app (DEC016); cada aba fica ativa para um grupo de seções via `data-pc-grupo` (DEC025). Menu lateral só com ícones em 1024–1279px e com rótulos a partir de 1280px (DEC024). Sem Bootstrap/collapse |
| F012 | Rolagem suave | pronta | `scroll-behavior: smooth` em `html`, desligado em `prefers-reduced-motion`; `scroll-padding-top` igual à faixa da seção e `scroll-padding-bottom` igual à barra de abas (mobile) |
| F013 | Revelar cartões ao rolar | pronta | `IntersectionObserver` adiciona `is-visivel` (fade + subir); sem suporte ou com movimento reduzido, cartões já visíveis (conteúdo nunca escondido sem JS) |
| F014 | Carrossel da galeria (JS puro) | pronta (aguardando conteúdo) | Montado a partir do array `TELAS` do `main.js`; anterior/próximo rotulados, indicadores com `aria-label`, setas do teclado; sem autoplay com movimento reduzido (DEC019). **Ainda não testado com imagens reais** (array `TELAS` vazio). |
| F015 | Botões de download | pronta (aguardando conteúdo) | Lidos de `LINKS_DOWNLOAD` no `main.js`; com link: `href` + `download`/nova aba; sem link: `aria-disabled`, `tabindex="-1"`, selo "Em breve" |
| F016 | Mascote com movimento reduzido | pronta | `<picture>` troca o GIF pelo `benchware.png` em `prefers-reduced-motion` (DEC009) |
| F017 | Publicação | pronta | Workflow `.github/workflows/pages.yml` (depende de DEC002) |
| F018 | Faixa da seção atual + destaque no menu | pronta | Faixa azul fixa no topo da coluna central (estilo "Seção 2, Unidade 7") com o nome da seção visível; o item correspondente do menu lateral/abas recebe `aria-current="true"` (fundo `--pc-azul-translucido`; `IntersectionObserver`, DEC018). Faixa só no desktop e `aria-hidden` (DEC023) |
| F019 | Barras das missões | pronta | Cada missão do painel tem barra amarela (`--pc-amarelo`) que enche conforme a rolagem da página; texto da missão sempre visível; sem transição com movimento reduzido (DEC016) |
| F020 | Balão das peças da trilha | pronta | Peça = `<button>` com `aria-expanded`/`aria-controls`; clique, Enter ou Espaço abre o balão com a descrição; Esc ou clique fora fecha e devolve o foco; um balão aberto por vez; sem JS, descrições visíveis (DEC017) |

Specs e tickets: `docs/specs/` e `docs/tickets/` (ainda vazios).
