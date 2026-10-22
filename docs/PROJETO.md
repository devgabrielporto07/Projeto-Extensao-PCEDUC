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
- **Equipe:** Professora Danielly, Gabriel Porto, Daniel Mota, Luiz Kaynan, Pedro Vinicius, Alfredo Alves,
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
| **Versão** | **v2** — trilha gamificada inspirada na tela da trilha do Duolingo web, tema escuro (DEC013–DEC027). CSS em 4 arquivos carregados nesta ordem: `base` → `layout` → `components` → `trilha`, + `main.js` com `defer` (DEC020). A v1 (Bootstrap, tema claro) está no commit `0fc3109` |
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
│   ├── css/base.css              tokens --pc-* (tema escuro), reset, tipografia, foco → view
│   ├── css/layout.css            menu lateral, 3 colunas, faixa, abas, painel missões → view
│   ├── css/components.css        componentes pc-* (cartões, botões 3D, galeria, equipe, download, rodapé) → view
│   ├── css/trilha.css            trilha em zigue-zague: nós 3D, baú, balões, mascote  → view
│   ├── js/main.js                comportamentos (JS puro): carrossel, menu, missões, trilha, download → view
│   └── assets/
│       ├── img/benchware-wave.gif   mascote acenando (cópia de assets/)
│       ├── img/benchware.png        quadro parado (prefers-reduced-motion)
│       └── telas/                   PNGs exportados do Figma (tela-01.png…)
├── assets/                       mídia do README (original do mascote)
├── Documentação/ · Pitch/ · Diagrama/ · Wireframe-Baixa-Fidelidade/   material acadêmico
├── README.md · CHANGELOG.md · LICENSE · .gitignore
```

## 4. Como rodar

- Abrir `site/index.html` no navegador, ou servir a pasta: `npx serve site`.
- Publicação: merge na `master` + `Settings → Pages → Source: GitHub Actions` (DEC002).
