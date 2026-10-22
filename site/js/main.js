/*
  PCEDUC — main.js
  Comportamentos da página: tema claro/escuro, navegação ativa (menu, abas e faixa), trilha com balões,
  mascote Benchware (entrada e troca de pose), mini quiz, barras das missões, revelar ao rolar, galeria,
  download e ano do rodapé.
  Dados editáveis ficam no topo (DEC008); as telas da galeria ficam no HTML e o JS só lê do DOM (DEC007).
  Sem bibliotecas e sem innerHTML.
*/
(function () {
  'use strict';

  // ===== Dados editáveis =====

  // TODO(AGENTE): preencher com a URL (https://) do instalador quando existir.
  // RN001: link vazio = botão desativado com selo "Em breve".
  const LINKS_DOWNLOAD = { windows: '', android: '' };

  // As telas da galeria ficam no index.html (seção #telas), não aqui: assim aparecem sem JS.

  const PASTA_MASCOTE = 'assets/img/mascote/';
  const movimentoReduzido = window.matchMedia('(prefers-reduced-motion: reduce)').matches;

  // ===== Rolagem: um único listener passivo, agrupado por requestAnimationFrame =====
  const tarefasDeRolagem = [];
  let quadroPendente = false;

  function aoRolar(tarefa) {
    tarefasDeRolagem.push(tarefa);
    tarefa();
  }

  function agendarRolagem() {
    if (quadroPendente) {
      return;
    }
    quadroPendente = true;
    window.requestAnimationFrame(function () {
      quadroPendente = false;
      tarefasDeRolagem.forEach(function (tarefa) {
        tarefa();
      });
    });
  }

  window.addEventListener('scroll', agendarRolagem, { passive: true });
  window.addEventListener('resize', agendarRolagem, { passive: true });

  function chegouAoFim() {
    const doc = document.documentElement;
    return window.innerHeight + window.scrollY >= doc.scrollHeight - 2;
  }

  // ===== Tema claro/escuro =====
  // Sem escolha salva, o CSS segue o sistema; a escolha do botão vai para data-tema e para o localStorage.
  // O script inline do <head> reaplica a escolha antes dos CSS (sem piscar).
  const CHAVE_TEMA = 'pc-tema';

  function salvarTema(tema) {
    try {
      window.localStorage.setItem(CHAVE_TEMA, tema);
    } catch (erro) {
      // localStorage bloqueado: o tema vale só até recarregar a página
    }
  }

  function configurarTema() {
    const botao = document.querySelector('[data-pc-tema]');
    if (!botao) {
      return;
    }

    const raiz = document.documentElement;
    const icone = botao.querySelector('[data-pc-tema-icone]');
    const rotulo = botao.querySelector('[data-pc-tema-rotulo]');
    const sistemaClaro = window.matchMedia('(prefers-color-scheme: light)');
    let temporizador = 0;

    function temaAtual() {
      const escolhido = raiz.getAttribute('data-tema');
      if (escolhido === 'claro' || escolhido === 'escuro') {
        return escolhido;
      }
      return sistemaClaro.matches ? 'claro' : 'escuro';
    }

    // O rótulo diz a ação (não o estado) e o ícone mostra o tema que será ativado
    function atualizarBotao() {
      const alvo = temaAtual() === 'claro' ? 'escuro' : 'claro';
      const texto = 'Ativar tema ' + alvo;
      if (rotulo) {
        rotulo.textContent = texto;
      }
      botao.title = texto;
      if (icone) {
        icone.setAttribute('href', alvo === 'claro' ? '#i-sol' : '#i-lua');
      }
    }

    // Com escolha feita, as duas metas (com media) passam a usar a cor de fundo do tema escolhido
    function atualizarCorDoNavegador() {
      const cor = window.getComputedStyle(raiz).getPropertyValue('--pc-fundo').trim();
      if (!cor) {
        return;
      }
      document.querySelectorAll('meta[name="theme-color"]').forEach(function (meta) {
        meta.setAttribute('content', cor);
      });
    }

    botao.addEventListener('click', function () {
      const alvo = temaAtual() === 'claro' ? 'escuro' : 'claro';
      // A classe liga a transição de cores só durante a troca (CSS desliga com movimento reduzido)
      raiz.classList.add('pc-tema-trocando');
      window.clearTimeout(temporizador);
      temporizador = window.setTimeout(function () {
        raiz.classList.remove('pc-tema-trocando');
      }, 400);

      raiz.setAttribute('data-tema', alvo);
      salvarTema(alvo);
      atualizarBotao();
      atualizarCorDoNavegador();
    });

    // Sem escolha salva, o tema muda junto com o sistema: o rótulo acompanha
    if (typeof sistemaClaro.addEventListener === 'function') {
      sistemaClaro.addEventListener('change', atualizarBotao);
    } else if (typeof sistemaClaro.addListener === 'function') {
      sistemaClaro.addListener(atualizarBotao);
    }

    atualizarBotao();
    botao.hidden = false;
  }

  // ===== Navegação ativa: menu lateral, abas inferiores e faixa da seção =====
  function configurarNavegacao() {
    const linksLateral = Array.from(document.querySelectorAll('.pc-lateral__link'));
    const linksAbas = Array.from(document.querySelectorAll('.pc-abas__link'));
    const faixaNumero = document.querySelector('[data-pc-faixa-numero]');
    const faixaNome = document.querySelector('[data-pc-faixa-nome]');

    // A ordem do menu lateral define a numeração "Seção N" da faixa
    const secoes = linksLateral.map(function (link) {
      return document.getElementById(link.getAttribute('href').slice(1));
    }).filter(Boolean);

    if (secoes.length === 0) {
      return;
    }

    let atual = '';

    function ativar(id) {
      if (id === atual) {
        return;
      }
      atual = id;

      linksLateral.forEach(function (link, indice) {
        const ativo = link.getAttribute('href') === '#' + id;
        if (ativo) {
          link.setAttribute('aria-current', 'true');
          if (faixaNumero && faixaNome) {
            faixaNumero.textContent = 'Seção ' + (indice + 1);
            faixaNome.textContent = link.textContent.trim();
          }
        } else {
          link.removeAttribute('aria-current');
        }
      });

      linksAbas.forEach(function (link) {
        const grupo = (link.getAttribute('data-pc-grupo') || '').split(' ');
        if (grupo.indexOf(id) !== -1) {
          link.setAttribute('aria-current', 'true');
        } else {
          link.removeAttribute('aria-current');
        }
      });
    }

    ativar(secoes[0].id);

    if (!('IntersectionObserver' in window)) {
      return;
    }

    // O painel de missões (no mobile, entre as seções) conta como parte de "Como funciona"
    const painel = document.getElementById('missoes');
    const observados = painel ? secoes.concat(painel) : secoes;
    const visiveis = new Set();
    const layoutDesktop = window.matchMedia('(min-width: 1024px)');

    // Faixa fina perto do meio da tela: a seção que a cruza é a "atual"
    const observador = new IntersectionObserver(function (entradas) {
      entradas.forEach(function (entrada) {
        if (entrada.isIntersecting) {
          visiveis.add(entrada.target);
        } else {
          visiveis.delete(entrada.target);
        }
      });

      if (chegouAoFim()) {
        return;
      }

      // No desktop o painel é a coluna fixa e cruza o meio da tela o tempo todo: não conta
      const primeira = observados.filter(function (el) {
        return visiveis.has(el) && !(el === painel && layoutDesktop.matches);
      }).sort(function (a, b) {
        return a.compareDocumentPosition(b) & Node.DOCUMENT_POSITION_FOLLOWING ? -1 : 1;
      })[0];

      if (primeira) {
        ativar(primeira === painel ? 'como-funciona' : primeira.id);
      }
    }, { rootMargin: '-40% 0px -55% 0px', threshold: 0 });

    observados.forEach(function (el) {
      observador.observe(el);
    });

    // A última seção é curta e pode nunca cruzar o meio da tela: no fim da página, ela fica ativa
    aoRolar(function () {
      if (chegouAoFim() && window.scrollY > 0) {
        ativar(secoes[secoes.length - 1].id);
      }
    });
  }

  // ===== Mascote: poses (PNG 320×320) =====
  function caminhoDaPose(pose) {
    return PASTA_MASCOTE + pose + '.png';
  }

  // Baixa as poses de reação antes do clique, para a troca não piscar
  function preCarregarPoses(poses) {
    poses.forEach(function (pose) {
      const imagem = new Image();
      imagem.src = caminhoDaPose(pose);
    });
  }

  // Crossfade + pulinho: uma cópia da pose atual some por cima enquanto a nova entra (CSS)
  function trocarPose(imagem, pose) {
    const caminho = caminhoDaPose(pose);
    if (!imagem || imagem.getAttribute('src') === caminho) {
      return;
    }
    if (movimentoReduzido) {
      imagem.setAttribute('src', caminho);
      return;
    }

    const caixa = imagem.parentElement;
    caixa.querySelectorAll('.pc-mascote__fantasma').forEach(function (antigo) {
      antigo.remove();
    });

    const fantasma = imagem.cloneNode(false);
    fantasma.classList.remove('is-trocando');
    fantasma.classList.add('pc-mascote__fantasma');
    fantasma.loading = 'eager';
    Array.from(fantasma.attributes).forEach(function (atributo) {
      if (atributo.name.indexOf('data-') === 0) {
        fantasma.removeAttribute(atributo.name);
      }
    });
    caixa.appendChild(fantasma);

    imagem.setAttribute('src', caminho);
    // Reinicia a animação mesmo se a troca anterior ainda não terminou
    imagem.classList.remove('is-trocando');
    void imagem.offsetWidth;
    imagem.classList.add('is-trocando');

    const remover = function () {
      fantasma.remove();
    };
    fantasma.addEventListener('animationend', remover, { once: true });
    window.setTimeout(remover, 500);
  }

  // ===== Mascote: "pula" para dentro quando a seção entra na tela =====
  function configurarMascotes() {
    const mascotes = document.querySelectorAll('.pc-mascote');
    // Sem suporte ou com movimento reduzido: os mascotes ficam visíveis, parados no lugar
    if (movimentoReduzido || !('IntersectionObserver' in window) || mascotes.length === 0) {
      return;
    }

    document.documentElement.classList.add('pc-mascote-ativo');

    const observador = new IntersectionObserver(function (entradas, obs) {
      entradas.forEach(function (entrada) {
        if (entrada.isIntersecting) {
          entrada.target.classList.add('is-visivel');
          obs.unobserve(entrada.target);
        }
      });
    }, { rootMargin: '0px 0px -10% 0px', threshold: 0.3 });

    mascotes.forEach(function (mascote) {
      observador.observe(mascote);
    });
  }

  // ===== Trilha: nós abrem balões com a descrição da peça =====
  function configurarTrilha() {
    const trilha = document.querySelector('.pc-trilha');
    if (!trilha) {
      return;
    }

    const botoes = Array.from(trilha.querySelectorAll('.pc-no'));
    const mascote = trilha.querySelector('[data-pc-mascote-trilha]');
    let aberto = null;

    if (mascote) {
      preCarregarPoses(['trofeu']);
    }

    // RF09: com o baú da peça rara aberto, o Benchware comemora com o troféu
    function atualizarMascote() {
      const bauAberto = aberto !== null && aberto.classList.contains('pc-no--bau');
      trocarPose(mascote, bauAberto ? 'trofeu' : 'construindo');
    }

    function balaoDe(botao) {
      return document.getElementById(botao.getAttribute('aria-controls'));
    }

    function fechar(devolverFoco) {
      if (!aberto) {
        return;
      }
      const botao = aberto;
      const balao = balaoDe(botao);
      if (balao) {
        balao.classList.remove('is-aberto');
      }
      botao.setAttribute('aria-expanded', 'false');
      aberto = null;
      atualizarMascote();
      if (devolverFoco) {
        botao.focus();
      }
    }

    function abrir(botao) {
      fechar(false);
      const balao = balaoDe(botao);
      if (!balao) {
        return;
      }
      balao.classList.add('is-aberto');
      botao.setAttribute('aria-expanded', 'true');
      aberto = botao;
      atualizarMascote();
    }

    botoes.forEach(function (botao) {
      botao.addEventListener('click', function () {
        if (aberto === botao) {
          fechar(false);
        } else {
          abrir(botao);
        }
      });
    });

    // Esc fecha e devolve o foco ao nó que abriu o balão
    document.addEventListener('keydown', function (evento) {
      if (evento.key === 'Escape' && aberto) {
        fechar(true);
      }
    });

    // Clique fora do nó e do balão fecha
    document.addEventListener('click', function (evento) {
      if (aberto && !aberto.parentElement.contains(evento.target)) {
        fechar(false);
      }
    });

    // Só agora os balões passam a ficar escondidos (se algo acima falhar, continuam visíveis)
    trilha.classList.add('pc-trilha--interativa');
  }

  // ===== Mini quiz "Experimente": troca o <details> pelas opções em botões =====
  const QUIZ_ACERTO = 'Isso aí! +XP';
  const QUIZ_EXPLICACAO = 'O processador é o cérebro do computador: ele executa as instruções.';

  function configurarQuiz() {
    const quiz = document.querySelector('[data-pc-quiz]');
    if (!quiz) {
      return;
    }

    const estatico = quiz.querySelector('[data-pc-quiz-estatico]');
    const interativo = quiz.querySelector('[data-pc-quiz-interativo]');
    const opcoes = Array.from(quiz.querySelectorAll('[data-pc-quiz-opcao]'));
    const feedback = quiz.querySelector('[data-pc-quiz-feedback]');
    const tentar = quiz.querySelector('[data-pc-quiz-tentar]');
    const mascote = document.querySelector('[data-pc-quiz-mascote]');

    // Falta alguma peça: o modo sem JS (pergunta + <details>) continua valendo
    if (!interativo || !feedback || !tentar || opcoes.length === 0) {
      return;
    }

    preCarregarPoses(['trofeu', 'errado']);

    function ehCorreta(opcao) {
      return opcao.getAttribute('data-pc-quiz-opcao') === 'correta';
    }

    // Estado com ícone (CSS) e rótulo em texto: a cor nunca é o único sinal
    function marcar(opcao, estado, rotulo) {
      opcao.setAttribute('data-pc-estado', estado);
      const status = opcao.querySelector('[data-pc-quiz-status]');
      if (status) {
        status.textContent = rotulo;
      }
    }

    function responder(escolhida) {
      const acertou = ehCorreta(escolhida);

      opcoes.forEach(function (opcao) {
        opcao.disabled = true;
        if (ehCorreta(opcao)) {
          marcar(opcao, 'correta', 'Correta');
        } else if (opcao === escolhida) {
          marcar(opcao, 'errada', 'Sua resposta');
        }
      });

      feedback.setAttribute('data-pc-estado', acertou ? 'acerto' : 'erro');
      feedback.textContent = acertou ? QUIZ_ACERTO : QUIZ_EXPLICACAO;
      trocarPose(mascote, acertou ? 'trofeu' : 'errado');

      // A opção clicada ficou desabilitada e perderia o foco: ele vai para "Tentar de novo"
      // (o feedback é anunciado pela região aria-live)
      tentar.hidden = false;
      tentar.focus();
    }

    function reiniciar() {
      opcoes.forEach(function (opcao) {
        opcao.disabled = false;
        opcao.removeAttribute('data-pc-estado');
        const status = opcao.querySelector('[data-pc-quiz-status]');
        if (status) {
          status.textContent = '';
        }
      });
      feedback.removeAttribute('data-pc-estado');
      feedback.textContent = '';
      trocarPose(mascote, 'duvida');
      tentar.hidden = true;
      opcoes[0].focus();
    }

    opcoes.forEach(function (opcao) {
      opcao.addEventListener('click', function () {
        responder(opcao);
      });
    });
    tentar.addEventListener('click', reiniciar);

    // Só agora troca o modo sem JS pelo interativo (se algo acima falhar, o <details> continua)
    if (estatico) {
      estatico.hidden = true;
    }
    interativo.hidden = false;
  }

  // ===== Missões: barras enchem com a rolagem (cada missão = 1/4 do percurso) =====
  function configurarMissoes() {
    const barras = Array.from(document.querySelectorAll('[data-pc-barra]'));
    if (barras.length === 0) {
      return;
    }

    aoRolar(function () {
      const doc = document.documentElement;
      const maximo = doc.scrollHeight - window.innerHeight;
      const progresso = maximo > 0 ? Math.min(1, Math.max(0, window.scrollY / maximo)) : 1;

      barras.forEach(function (barra, indice) {
        const valor = Math.min(1, Math.max(0, progresso * barras.length - indice));
        barra.style.setProperty('--pc-progresso', valor.toFixed(3));
      });
    });
  }

  // ===== Revelar ao rolar (F013) =====
  function revelarAoRolar() {
    const elementos = document.querySelectorAll('.pc-revelar');
    // Sem suporte ou com movimento reduzido: nada é escondido
    if (movimentoReduzido || !('IntersectionObserver' in window) || elementos.length === 0) {
      return;
    }

    // A classe ativa o estado inicial oculto só depois de confirmar que o observer existe
    document.documentElement.classList.add('pc-revelar-ativo');

    const observador = new IntersectionObserver(function (entradas, obs) {
      entradas.forEach(function (entrada) {
        if (entrada.isIntersecting) {
          entrada.target.classList.add('is-visivel');
          obs.unobserve(entrada.target);
        }
      });
    }, { rootMargin: '0px 0px -10% 0px', threshold: 0.1 });

    elementos.forEach(function (elemento) {
      observador.observe(elemento);
    });
  }

  // ===== Download (F015 / RN001) =====
  function configurarDownloads() {
    document.querySelectorAll('[data-pc-download]').forEach(function (botao) {
      const plataforma = botao.getAttribute('data-pc-download');
      const link = (LINKS_DOWNLOAD[plataforma] || '').trim();

      // Só aceita https: evita "javascript:" ou link digitado errado virar botão ativo
      if (/^https:\/\//i.test(link)) {
        ativarDownload(botao, link);
      } else {
        desativarDownload(botao);
      }
    });
  }

  function ativarDownload(botao, link) {
    botao.setAttribute('href', link);
    botao.setAttribute('target', '_blank');
    botao.setAttribute('rel', 'noopener');
    botao.removeAttribute('aria-disabled');
    botao.removeAttribute('tabindex');
    botao.classList.add('pc-btn--verde');

    const selo = botao.querySelector('[data-pc-download-selo]');
    if (selo) {
      selo.remove();
    }

    const aviso = document.createElement('span');
    aviso.className = 'pc-sr';
    aviso.textContent = ' (abre em nova aba)';
    botao.appendChild(aviso);
  }

  function desativarDownload(botao) {
    botao.removeAttribute('href');
    botao.setAttribute('aria-disabled', 'true');
    botao.setAttribute('tabindex', '-1');
    // Sem href o clique já não navega; o preventDefault é uma garantia extra
    botao.addEventListener('click', function (evento) {
      if (botao.getAttribute('aria-disabled') === 'true') {
        evento.preventDefault();
      }
    });
  }

  // ===== Galeria (F014 / RN003): carrossel sobre a faixa com scroll-snap, sem autoplay =====
  // As telas vêm do HTML (fonte única, aparecem sem JS); aqui só entram controles, indicadores e o
  // reservado "Tela em breve" para imagem que não carregou. O arrastar/rolar é o nativo do navegador.
  function trocarPorReservado(imagem) {
    const celular = document.createElement('div');
    celular.className = 'pc-celular';
    const tela = document.createElement('div');
    tela.className = 'pc-celular__tela pc-celular__tela--reservada';
    const texto = document.createElement('span');
    texto.textContent = 'Tela em breve';
    tela.appendChild(texto);
    celular.appendChild(tela);
    imagem.replaceWith(celular);
  }

  function vigiarImagem(imagem) {
    // A imagem pode ter falhado antes de o JS rodar (o evento já passou)
    if (imagem.complete && imagem.naturalWidth === 0) {
      trocarPorReservado(imagem);
      return;
    }
    imagem.addEventListener('error', function () {
      trocarPorReservado(imagem);
    }, { once: true });
  }

  function criarBotao(classe, texto) {
    const botao = document.createElement('button');
    botao.type = 'button';
    botao.className = classe;
    if (texto) {
      botao.textContent = texto;
    }
    return botao;
  }

  // Botão "Tela anterior"/"Próxima tela" com a seta só visual
  function criarBotaoSeta(texto, seta, setaAntes) {
    const botao = criarBotao('pc-btn pc-btn--azul pc-carrossel__botao');
    const icone = document.createElement('span');
    icone.className = 'pc-carrossel__seta';
    icone.setAttribute('aria-hidden', 'true');
    icone.textContent = seta;
    // No celular o CSS esconde o rótulo só visualmente: continua sendo o nome do botão
    const rotulo = document.createElement('span');
    rotulo.className = 'pc-carrossel__rotulo';
    rotulo.textContent = texto;
    if (setaAntes) {
      botao.append(icone, rotulo);
    } else {
      botao.append(rotulo, icone);
    }
    return botao;
  }

  function legendaDe(slide) {
    const legenda = slide.querySelector('figcaption');
    return legenda ? legenda.textContent.trim() : '';
  }

  function montarGaleria() {
    const galeria = document.querySelector('[data-pc-galeria]');
    const trilho = galeria && galeria.querySelector('[data-pc-galeria-trilho]');
    if (!trilho) {
      return;
    }
    const slides = Array.from(trilho.children);
    trilho.querySelectorAll('img').forEach(vigiarImagem);
    if (slides.length < 2) {
      return;
    }

    galeria.setAttribute('role', 'region');
    galeria.setAttribute('aria-roledescription', 'carrossel');
    galeria.setAttribute('aria-label', 'Telas do app');
    slides.forEach(function (slide, indice) {
      slide.setAttribute('role', 'group');
      slide.setAttribute('aria-roledescription', 'slide');
      slide.setAttribute('aria-label', (indice + 1) + ' de ' + slides.length);
    });

    const controles = document.createElement('div');
    controles.className = 'pc-carrossel__controles';
    const anterior = criarBotaoSeta('Tela anterior', '←', true);
    const proxima = criarBotaoSeta('Próxima tela', '→', false);
    const grupoIndicadores = document.createElement('div');
    grupoIndicadores.className = 'pc-carrossel__indicadores';
    // Todos os slides ficam no DOM (não há troca de conteúdo), então a tela atual é anunciada à parte
    const aviso = document.createElement('p');
    aviso.className = 'pc-sr';
    aviso.setAttribute('aria-live', 'polite');

    let atual = -1;
    const indicadores = slides.map(function (slide, indice) {
      const indicador = criarBotao('pc-carrossel__indicador', '');
      indicador.setAttribute('aria-label', 'Ir para a tela ' + (indice + 1) + ': ' + legendaDe(slide));
      indicador.addEventListener('click', function () {
        irPara(indice);
      });
      grupoIndicadores.appendChild(indicador);
      return indicador;
    });

    // Marca a tela atual (escala/opacidade no CSS) e o indicador; o aviso só fala quando muda
    function marcar(indice, anunciar) {
      if (indice === atual) {
        return;
      }
      atual = indice;
      slides.forEach(function (slide, i) {
        slide.classList.toggle('is-atual', i === atual);
      });
      indicadores.forEach(function (indicador, i) {
        if (i === atual) {
          indicador.setAttribute('aria-current', 'true');
        } else {
          indicador.removeAttribute('aria-current');
        }
      });
      if (anunciar) {
        aviso.textContent = 'Tela ' + (atual + 1) + ' de ' + slides.length + ': ' + legendaDe(slides[atual]);
      }
    }

    // Durante a rolagem suave pedida por botão/tecla, o slide do centro ainda é o antigo: sem esta trava,
    // dois cliques rápidos em "Próxima tela" iriam para a mesma tela
    let destino = null;
    let liberarDestino = 0;

    // Rola só o trilho (scrollIntoView poderia mover a página na vertical)
    function irPara(indice) {
      const alvo = (indice + slides.length) % slides.length;
      const slide = slides[alvo];
      const maximo = trilho.scrollWidth - trilho.clientWidth;
      const esquerda = slide.offsetLeft - (trilho.clientWidth - slide.offsetWidth) / 2;
      destino = Math.min(Math.max(esquerda, 0), maximo);
      window.clearTimeout(liberarDestino);
      // Segurança: se o usuário interromper a rolagem, a trava sai sozinha
      liberarDestino = window.setTimeout(function () {
        destino = null;
      }, 1000);
      trilho.scrollTo({ left: destino, behavior: movimentoReduzido ? 'auto' : 'smooth' });
      marcar(alvo, true);
    }

    // Slide mais perto do centro do trilho; recalculado no máximo uma vez por quadro
    function slideNoCentro() {
      const centro = trilho.scrollLeft + trilho.clientWidth / 2;
      let maisPerto = 0;
      let menorDistancia = Infinity;
      slides.forEach(function (slide, i) {
        const distancia = Math.abs(slide.offsetLeft + slide.offsetWidth / 2 - centro);
        if (distancia < menorDistancia) {
          menorDistancia = distancia;
          maisPerto = i;
        }
      });
      return maisPerto;
    }

    let quadro = 0;
    trilho.addEventListener('scroll', function () {
      if (quadro) {
        return;
      }
      quadro = window.requestAnimationFrame(function () {
        quadro = 0;
        if (destino !== null) {
          if (Math.abs(trilho.scrollLeft - destino) > 2) {
            return;
          }
          destino = null;
        }
        marcar(slideNoCentro(), true);
      });
    }, { passive: true });

    anterior.addEventListener('click', function () {
      irPara(atual - 1);
    });
    proxima.addEventListener('click', function () {
      irPara(atual + 1);
    });

    // Setas do teclado trocam a tela quando o foco está dentro do carrossel
    galeria.addEventListener('keydown', function (evento) {
      if (evento.key === 'ArrowLeft') {
        evento.preventDefault();
        irPara(atual - 1);
      } else if (evento.key === 'ArrowRight') {
        evento.preventDefault();
        irPara(atual + 1);
      }
    });

    controles.append(anterior, grupoIndicadores, proxima);
    galeria.append(controles, aviso);
    galeria.classList.add('pc-galeria--carrossel');
    // Começa centralizado na 1ª tela, sem anunciar (ninguém pediu a troca)
    marcar(0, false);
    trilho.scrollLeft = 0;
  }

  // ===== Rodapé =====
  function atualizarAno() {
    document.querySelectorAll('[data-pc-ano]').forEach(function (elemento) {
      elemento.textContent = String(new Date().getFullYear());
    });
  }

  // Cada passo isolado: um erro em um não impede os outros de rodarem
  function iniciar() {
    document.documentElement.classList.add('js');

    [
      configurarTema,
      configurarNavegacao,
      configurarTrilha,
      configurarQuiz,
      // Depois da trilha: o mascote dela só fica visível (observável) com a trilha interativa
      configurarMascotes,
      configurarMissoes,
      revelarAoRolar,
      configurarDownloads,
      montarGaleria,
      atualizarAno
    ].forEach(function (passo) {
      try {
        passo();
      } catch (erro) {
        console.error('PCEDUC:', passo.name, erro);
      }
    });
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', iniciar);
  } else {
    iniciar();
  }
})();
