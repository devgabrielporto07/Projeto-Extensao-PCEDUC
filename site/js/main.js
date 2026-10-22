/*
  PCEDUC — main.js
  Comportamentos da página: navegação ativa (menu, abas e faixa), trilha com balões,
  barras das missões, revelar ao rolar, galeria, download e ano do rodapé.
  Dados editáveis ficam no topo (DEC007, DEC008). Sem bibliotecas e sem innerHTML.
*/
(function () {
  'use strict';

  // ===== Dados editáveis =====

  // TODO(AGENTE): preencher com a URL (https://) do instalador quando existir.
  // RN001: link vazio = botão desativado com selo "Em breve".
  const LINKS_DOWNLOAD = { windows: '', android: '' };

  // TODO(AGENTE): listar as telas exportadas do Figma em site/assets/telas/.
  // Formato: { arquivo: 'tela-01.png', legenda: 'Descrição da tela (vira o alt)' }
  const TELAS = [];

  const PASTA_TELAS = 'assets/telas/';
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

  // ===== Trilha: nós abrem balões com a descrição da peça =====
  function configurarTrilha() {
    const trilha = document.querySelector('.pc-trilha');
    if (!trilha) {
      return;
    }

    const botoes = Array.from(trilha.querySelectorAll('.pc-no'));
    let aberto = null;

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

  // ===== Galeria (F014 / RN003): carrossel em JS puro, sem autoplay =====
  function criarTelaReservada() {
    const tela = document.createElement('div');
    tela.className = 'pc-celular__tela pc-celular__tela--reservada';
    const texto = document.createElement('span');
    texto.textContent = 'Tela em breve';
    tela.appendChild(texto);
    return tela;
  }

  function criarSlide(item, indice, total) {
    const slide = document.createElement('div');
    slide.className = 'pc-carrossel__slide';
    slide.setAttribute('role', 'group');
    slide.setAttribute('aria-roledescription', 'slide');
    slide.setAttribute('aria-label', (indice + 1) + ' de ' + total);
    slide.hidden = indice !== 0;

    const figura = document.createElement('figure');
    const celular = document.createElement('div');
    celular.className = 'pc-celular';

    const tela = document.createElement('div');
    tela.className = 'pc-celular__tela';

    const imagem = document.createElement('img');
    imagem.src = PASTA_TELAS + item.arquivo;
    imagem.alt = item.legenda || '';
    imagem.loading = 'lazy';
    imagem.decoding = 'async';
    // RN003: imagem que não carrega vira o reservado "Tela em breve"
    imagem.addEventListener('error', function () {
      celular.replaceChild(criarTelaReservada(), tela);
    }, { once: true });

    tela.appendChild(imagem);
    celular.appendChild(tela);
    figura.appendChild(celular);

    if (item.legenda) {
      const legenda = document.createElement('figcaption');
      legenda.className = 'pc-galeria__legenda';
      legenda.textContent = item.legenda;
      figura.appendChild(legenda);
    }

    slide.appendChild(figura);
    return slide;
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

  function montarGaleria() {
    const container = document.querySelector('[data-pc-galeria]');
    // Lista vazia: os reservados do HTML continuam como estão
    if (!container || TELAS.length === 0) {
      return;
    }

    const carrossel = document.createElement('div');
    carrossel.className = 'pc-carrossel';
    carrossel.setAttribute('role', 'region');
    carrossel.setAttribute('aria-roledescription', 'carrossel');
    carrossel.setAttribute('aria-label', 'Telas do app');

    // Sem autoplay, então a troca pode ser anunciada com educação (polite)
    const trilho = document.createElement('div');
    trilho.setAttribute('aria-live', 'polite');

    const slides = TELAS.map(function (item, indice) {
      const slide = criarSlide(item, indice, TELAS.length);
      trilho.appendChild(slide);
      return slide;
    });
    carrossel.appendChild(trilho);

    if (TELAS.length > 1) {
      let atual = 0;
      const indicadores = [];

      const controles = document.createElement('div');
      controles.className = 'pc-carrossel__controles';
      const anterior = criarBotao('pc-btn pc-btn--azul', 'Tela anterior');
      const proxima = criarBotao('pc-btn pc-btn--azul', 'Próxima tela');
      const grupoIndicadores = document.createElement('div');
      grupoIndicadores.className = 'pc-carrossel__indicadores';

      const mostrar = function (indice) {
        atual = (indice + slides.length) % slides.length;
        slides.forEach(function (slide, i) {
          slide.hidden = i !== atual;
        });
        indicadores.forEach(function (indicador, i) {
          if (i === atual) {
            indicador.setAttribute('aria-current', 'true');
          } else {
            indicador.removeAttribute('aria-current');
          }
        });
      };

      slides.forEach(function (slide, indice) {
        const indicador = criarBotao('pc-carrossel__indicador', '');
        indicador.setAttribute('aria-label', 'Ir para a tela ' + (indice + 1));
        indicador.addEventListener('click', function () {
          mostrar(indice);
        });
        indicadores.push(indicador);
        grupoIndicadores.appendChild(indicador);
      });

      anterior.addEventListener('click', function () {
        mostrar(atual - 1);
      });
      proxima.addEventListener('click', function () {
        mostrar(atual + 1);
      });

      // Setas do teclado trocam a tela quando o foco está dentro do carrossel
      carrossel.addEventListener('keydown', function (evento) {
        if (evento.key === 'ArrowLeft') {
          evento.preventDefault();
          mostrar(atual - 1);
        } else if (evento.key === 'ArrowRight') {
          evento.preventDefault();
          mostrar(atual + 1);
        }
      });

      controles.appendChild(anterior);
      controles.appendChild(grupoIndicadores);
      controles.appendChild(proxima);
      carrossel.appendChild(controles);
      mostrar(0);
    }

    container.replaceChildren(carrossel);
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
      configurarNavegacao,
      configurarTrilha,
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
