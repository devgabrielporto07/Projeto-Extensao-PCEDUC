# Funcionalidades — Site demonstrativo do PCEDUC

Status: `planejada` · `em andamento` · `pronta`. Fontes: **README** (`README.md`), **PITCH** (`Pitch/PC educ.pdf`),
**REQ** (`Documentação/.../PCEDUC-Proposito-e-Requisitos.pdf`). "PC educ" do pitch vira "PCEDUC" (DEC006).
Os textos abaixo são a base; o agente view pode encurtar, mas não inventar conteúdo (RN002).

## Seções da página (ordem — DEC005)

| ID | Seção (âncora) | Status | Conteúdo | Fonte |
|---|---|---|---|---|
| F001 | Topo / hero (navbar + `<h1>`) | planejada | Mascote Benchware; "PCEDUC"; slogan "Aprenda hardware jogando: trilhas, pontos e conquistas."; "Projeto de extensão da UNINASSAU Campina Grande — Ciência da Computação"; botões "Baixar o app" (→ `#download`) e "Conheça o protótipo" (Figma) | README |
| F002 | Por que ensinar hardware? (`#por-que`) | planejada | "Usamos computadores todos os dias, mas poucos sabem como eles funcionam por dentro." / "O PCEDUC transforma essa curiosidade em aprendizado, passo a passo e sem complicação." | PITCH |
| F003 | O que é o PCEDUC? (`#o-que-e`) | planejada | "Um app que ensina jogando": aplicativo no estilo do Duolingo, conteúdo dividido em trilhas, cada lição concluída rende pontos e conquistas. "Foco em hardware": explica o que cada componente faz e como funciona, de forma simples e visual. | PITCH + README |
| F004 | Como funciona (`#como-funciona`) | planejada | 4 passos: **Trilhas de aprendizado** (lições em sequência, cada trilha leva um passo adiante); **Pontuação / XP** (cada lição concluída soma pontos e mostra o progresso; XP define o nível); **Conquistas** (medalhas e marcos recompensam a dedicação); **Peças colecionáveis** (ao concluir trilhas ou metas de XP, ganha peças virtuais que montam um PC completo no perfil; às vezes uma peça rara-surpresa) | PITCH + REQ §3 + README |
| F005 | O que se aprende (`#o-que-se-aprende`) | planejada | Placa-mãe — "Conecta e integra todos os componentes."; Processador — "O cérebro que executa as instruções."; Placa de vídeo — "Gera as imagens exibidas na tela."; Memória RAM — "Guarda os dados em uso no momento."; Armazenamento — "Mantém arquivos e programas salvos."; Fonte de energia — "Fornece energia a cada peça." Fecho: "E muito mais, trilha após trilha." | PITCH |
| F006 | Para quem é (`#para-quem`) | planejada | "Voltado ao ensino médio": foco nos adolescentes; crianças e adultos também aprendem no seu ritmo. Cartões: **Crianças** (etapas curtas e visual divertido…), **Adolescentes** (estudantes do ensino médio: desafios e pontuação despertam a curiosidade por tecnologia), **Adultos** (forma prática de entender o computador do dia a dia) | PITCH |
| F007 | Galeria de telas (`#galeria`) | planejada | Carrossel com as telas do app (`site/assets/telas/tela-XX.png`); reservado "Tela em breve" quando faltar a imagem (RN003); link "Ver o protótipo completo no Figma" | Figma (DEC007) |
| F008 | Equipe (`#equipe`) | planejada | 7 integrantes com nome e link do GitHub, conforme a tabela do README (RN004) | README |
| F009 | Download (`#download`) | planejada | "Baixar o app": botões **Windows** e **Android**; desativados com selo "Em breve" enquanto não houver link (RN001) | Decisão do usuário (DEC008, DEC010) |
| F010 | Rodapé | planejada | "Aprender hardware pode ser divertido."; PCEDUC — Projeto de Extensão, UNINASSAU Campina Grande; licença Apache 2.0; links para o repositório e para abrir issue | PITCH + README |

## Comportamentos

| ID | Comportamento | Status | Detalhe |
|---|---|---|---|
| F011 | Menu mobile | planejada | Navbar do Bootstrap com collapse (`navbar-expand-lg`); fechar o menu ao clicar em um link de seção |
| F012 | Rolagem suave | planejada | `scroll-behavior: smooth` em `html`, desligado em `prefers-reduced-motion`; `scroll-padding-top` igual à altura da navbar fixa |
| F013 | Revelar cartões ao rolar | planejada | `IntersectionObserver` adiciona `is-visivel` (fade + subir); sem suporte ou com movimento reduzido, cartões já visíveis (conteúdo nunca escondido sem JS) |
| F014 | Carrossel da galeria | planejada | Carousel do Bootstrap montado a partir do array `TELAS` do `main.js`; sem autoplay com movimento reduzido; controles e indicadores rotulados |
| F015 | Botões de download | planejada | Lidos de `LINKS_DOWNLOAD` no `main.js`; com link: `href` + `download`/nova aba; sem link: `aria-disabled`, `tabindex="-1"`, selo "Em breve" |
| F016 | Mascote com movimento reduzido | planejada | `<picture>` troca o GIF pelo `benchware.png` em `prefers-reduced-motion` (DEC009) |
| F017 | Publicação | pronta | Workflow `.github/workflows/pages.yml` (depende de DEC002) |

Specs e tickets: `docs/specs/` e `docs/tickets/` (ainda vazios).
