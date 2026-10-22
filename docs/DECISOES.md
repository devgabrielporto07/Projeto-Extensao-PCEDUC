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

## DEC003 — Bootstrap 5.3 via CDN (muda a decisão original "sem framework")
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

## DEC004 — Variáveis do Bootstrap sobrescritas pelos tokens do PCEDUC
- **Data:** 2026-10-21
- **Decisão:** `base.css` define os tokens `--pc-*` e sobrescreve `--bs-*` (primária, fonte, corpo, bordas)
  para que os componentes do Bootstrap herdem a identidade visual (ver `IDENTIDADE_VISUAL.md`).
- **Motivo:** evitar visual "Bootstrap padrão" e manter uma única fonte de verdade para cores.

## DEC005 — Seções e ordem da página
- **Data:** 2026-10-21
- **Decisão:** Topo → Por que ensinar hardware → O que é → Como funciona (trilhas → XP → conquistas → peças)
  → O que se aprende (placa-mãe, CPU, GPU, RAM, armazenamento, fonte) → Para quem é → Galeria → Equipe → Download → Rodapé.
- **Motivo:** segue a narrativa do pitch (`Pitch/PC educ.pdf`), acrescentando peças colecionáveis (requisitos), galeria, equipe e download.

## DEC006 — Nome oficial "PCEDUC"
- **Data:** 2026-10-21
- **Decisão:** o site usa sempre **PCEDUC**. O pitch escreve "PC educ"; textos dele são adaptados para o nome oficial.
- **Motivo:** consistência com README, requisitos e repositório.

## DEC007 — Galeria com espaços reservados
- **Data:** 2026-10-21
- **Decisão:** a galeria lista as telas no array do `main.js`; enquanto o PNG não existir em `site/assets/telas/`,
  exibe um cartão "Tela em breve".
- **Motivo:** as telas ainda não foram exportadas do Figma; o site não pode quebrar nem mostrar imagem inventada.

## DEC008 — Download desativado até haver links
- **Data:** 2026-10-21
- **Decisão:** botões "Baixar para Windows" e "Baixar para Android" ficam desativados (`aria-disabled="true"`,
  sem `href`, fora da ordem de tabulação) com selo "Em breve" enquanto o link estiver vazio. Os links ficam
  centralizados em um único objeto no `main.js`.
- **Motivo:** o app ainda não tem instaladores publicados; um único lugar para trocar os links.

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
