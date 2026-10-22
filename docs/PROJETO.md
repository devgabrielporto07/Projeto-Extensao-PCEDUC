# PCEDUC — Projeto

> **Aprenda hardware jogando: trilhas, pontos e conquistas.**
> Projeto de extensão da **UNINASSAU Campina Grande** — Ciência da Computação. Licença Apache 2.0.

## 1. Visão do PCEDUC (resumo das fontes)

Fontes: `README.md`, `Documentação/Modelo-Engenharia-Software/Modelo-Prototipagem/PDF/PCEDUC-Proposito-e-Requisitos.pdf`
e `Pitch/PC educ.pdf`.

- **Origem:** o projeto começou como "PC Benchmark", um site informativo sobre hardware (consulta,
  comparação e consumo de energia). Foi reformulado para explorar melhor o eixo Educação e Tecnologia.
- **Propósito:** ensinar conceitos de hardware de forma acessível, prática e envolvente, por meio de uma
  plataforma gamificada no estilo do Duolingo.
- **Como funciona:** o conteúdo é dividido em **trilhas** (ex.: Processador, Placa de Vídeo, Memória RAM,
  Armazenamento, Fonte de Alimentação) com lições curtas e exercícios (múltipla escolha, verdadeiro/falso,
  associação). Cada acerto rende **XP**, que define o **nível**. Em marcos, o usuário ganha **peças virtuais**
  que montam um PC completo no perfil — às vezes uma peça rara como recompensa-surpresa.
- **Mascote:** **Benchware**, que acompanha a jornada com incentivos, dicas e comemorações.
- **Público:** foco em estudantes do **ensino médio**; crianças e adultos também aprendem no seu ritmo.
- **Equipe:** Professor Daniel, Gabriel Porto, Daniel Mota, Luiz Kaynan, Pedro Vinicius, Alfredo Alves,
  Sara Arruda (ver `README.md`).
- **Protótipo:** [Figma — Telas PCEDUC](https://www.figma.com/proto/Nds3cFqZtrh3N2oKh1um8q/Telas-PCEDUC?node-id=10-2&t=ofcFB11myQ6Vvf07-1).

> Divergência registrada (DEC010): o documento de requisitos descreve uma aplicação web ASP.NET Core MVC
> mobile-first; o README lista aplicativo mobile em Flutter. O site demonstrativo segue o README e a
> decisão do usuário (botões de download para Windows e Android).

## 2. Site demonstrativo (escopo deste trabalho)

| Item | Valor |
|---|---|
| **Objetivo** | Apresentar o PCEDUC para alunos, professores e avaliadores: o que é, como funciona, o que se aprende, telas do app, equipe e botão **Baixar o app** (Windows / Android) |
| **Público** | Estudantes (foco no ensino médio), professores, avaliadores do projeto de extensão |
| **Plataforma** | Web — página de apresentação estática (uma página) |
| **Arquitetura** | Estática, sem MVC/back-end (HTML + CSS + JS) |
| **Versão** | **v2** — trilha gamificada inspirada na tela da trilha do Duolingo web, tema escuro (DEC013–DEC027) + tema claro com botão de alternar, padrão segue o sistema (DEC028–DEC030) + poses animadas do mascote, baú interativo, mini quiz "Experimente" e página 404 (DEC031–DEC037) + galeria com as 4 telas reais do app, que ficam no `index.html` (fonte única; o `main.js` só lê os slides do DOM e monta o carrossel — DEC038). No `index.html`, CSS em 7 arquivos carregados nesta ordem: `base` → `layout` → `components` → `galeria` → `trilha` → `mascote` → `quiz`, + `main.js` com `defer` (DEC020); a `404.html` carrega `base` → `components` → `mascote` → `erro`, sem JS externo (DEC036). A v1 (Bootstrap, tema claro) está no commit `0fc3109` |
| **Linguagem e frameworks** | HTML5, CSS3 e JavaScript puro, sem framework e sem build (Bootstrap removido na v2 — DEC013); única dependência externa: Google Fonts |
| **Gerência de estado** | Não se aplica |
| **Hospedagem** | GitHub Pages via GitHub Actions (`.github/workflows/pages.yml`) |
| **Nível** | simples |
| **Ciclo de qualidade** | desligado |

Ciclo de qualidade: desligado

## 3. Mapa de pastas

```
Projeto-Extensao-PCEDUC/
├── .github/workflows/pages.yml   publica site/ no GitHub Pages            → document
├── docs/                         memória do projeto                        → document
├── site/                         raiz publicada no Pages
│   ├── index.html                página única                              → view
│   ├── 404.html                  página de erro do Pages (caminhos absolutos — DEC036) → view
│   ├── css/base.css              tokens --pc-* (tema escuro/claro), reset, tipografia, foco → view
│   ├── css/layout.css            menu lateral, 3 colunas, faixa, abas, painel missões → view
│   ├── css/components.css        componentes pc-* (cartões, botões 3D, equipe, download, rodapé) → view
│   ├── css/galeria.css           galeria "Telas do app": scroll-snap, carrossel, reservado (DEC038) → view
│   ├── css/trilha.css            trilha em zigue-zague: nós 3D, baú (botão), balões   → view
│   ├── css/mascote.css           mascote nas seções e na trilha + animações (DEC033)  → view
│   ├── css/quiz.css              mini quiz "Experimente" (DEC035)                     → view
│   ├── css/erro.css              layout da 404 (só na 404.html)                       → view
│   ├── js/main.js                comportamentos (JS puro): tema, menu, missões, trilha, mascotes, quiz, carrossel, download → view
│   └── assets/
│       ├── img/benchware-wave.gif   mascote acenando no topo (cópia de assets/)
│       ├── img/benchware.png        quadro parado (prefers-reduced-motion)
│       ├── img/mascote/             11 poses PNG transparentes 320×320 (DEC031)
│       └── telas/                   4 telas reais do app, PNG 540×1080 com moldura de iPhone (tela-01…04.png, DEC038) + README.md
├── assets/                       mídia do README (original do mascote)
├── Documentação/ · Pitch/ · Diagrama/ · Wireframe-Baixa-Fidelidade/   material acadêmico
├── README.md · CHANGELOG.md · LICENSE · .gitignore
```

## 4. Como rodar

- Abrir `site/index.html` no navegador, ou servir a pasta: `npx serve site`.
- Publicação: merge na `master` + `Settings → Pages → Source: GitHub Actions` (DEC002).
