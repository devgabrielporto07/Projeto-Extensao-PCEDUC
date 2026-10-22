/*
  PCEDUC — main.js
  Comportamentos da página: botões de download, galeria de telas, revelar ao rolar,
  fechar o menu mobile e ano do rodapé. Dados editáveis ficam no topo (DEC007, DEC008).
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
    botao.classList.add('pc-btn--destaque');

    const selo = botao.querySelector('[data-pc-download-selo]');
    if (selo) {
      selo.remove();
    }

    const aviso = document.createElement('span');
    aviso.className = 'visually-hidden';
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

  // ===== Galeria (F014 / RN003) =====
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
    slide.className = 'carousel-item' + (indice === 0 ? ' active' : '');
    slide.setAttribute('role', 'group');
    slide.setAttribute('aria-roledescription', 'slide');
    slide.setAttribute('aria-label', (indice + 1) + ' de ' + total);

    const figura = document.createElement('figure');
    figura.className = 'pc-galeria__slide';

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

  function criarIndicador(idCarrossel, indice) {
    const indicador = document.createElement('button');
    indicador.type = 'button';
    indicador.setAttribute('data-bs-target', '#' + idCarrossel);
    indicador.setAttribute('data-bs-slide-to', String(indice));
    indicador.setAttribute('aria-label', 'Ir para a tela ' + (indice + 1));
    if (indice === 0) {
      indicador.className = 'active';
      indicador.setAttribute('aria-current', 'true');
    }
    return indicador;
  }

  function criarControle(idCarrossel, direcao, rotulo) {
    const controle = document.createElement('button');
    controle.type = 'button';
    controle.className = 'pc-btn pc-btn--primario';
    controle.setAttribute('data-bs-target', '#' + idCarrossel);
    controle.setAttribute('data-bs-slide', direcao);
    controle.textContent = rotulo;
    return controle;
  }

  function montarGaleria() {
    const container = document.querySelector('[data-pc-galeria]');
    // Lista vazia: os reservados do HTML continuam como estão
    if (!container || TELAS.length === 0) {
      return;
    }

    const idCarrossel = 'pc-carrossel';
    const carrossel = document.createElement('div');
    carrossel.id = idCarrossel;
    carrossel.className = 'carousel slide pc-galeria__carrossel';
    carrossel.setAttribute('role', 'region');
    carrossel.setAttribute('aria-roledescription', 'carrossel');
    carrossel.setAttribute('aria-label', 'Telas do app');

    const trilho = document.createElement('div');
    trilho.className = 'carousel-inner';

    const indicadores = document.createElement('div');
    indicadores.className = 'carousel-indicators';

    TELAS.forEach(function (item, indice) {
      trilho.appendChild(criarSlide(item, indice, TELAS.length));
      indicadores.appendChild(criarIndicador(idCarrossel, indice));
    });

    carrossel.appendChild(trilho);

    if (TELAS.length > 1) {
      const controles = document.createElement('div');
      controles.className = 'pc-galeria__controles';
      controles.appendChild(criarControle(idCarrossel, 'prev', 'Tela anterior'));
      controles.appendChild(criarControle(idCarrossel, 'next', 'Próxima tela'));
      carrossel.appendChild(controles);
      carrossel.appendChild(indicadores);
    }

    container.replaceChildren(carrossel);

    // Sem autoplay: o usuário controla a troca (acessibilidade e movimento reduzido)
    if (window.bootstrap && window.bootstrap.Carousel) {
      window.bootstrap.Carousel.getOrCreateInstance(carrossel, { ride: false, interval: false, touch: true });
    }
  }

  // ===== Revelar ao rolar (F013) =====
  function revelarAoRolar() {
    const elementos = document.querySelectorAll('.pc-revelar');
    // Sem suporte ou com movimento reduzido: nada é escondido
    if (movimentoReduzido || !('IntersectionObserver' in window) || elementos.length === 0) {
      return;
    }

    // A classe "js" ativa o estado inicial oculto só depois de confirmar que o observer existe
    document.documentElement.classList.add('js');

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

  // ===== Menu mobile (F011) =====
  function fecharMenuAoNavegar() {
    const menu = document.getElementById('pc-menu');
    if (!menu) {
      return;
    }

    menu.addEventListener('click', function (evento) {
      const link = evento.target.closest('a.nav-link');
      if (!link || !menu.classList.contains('show') || !window.bootstrap) {
        return;
      }
      window.bootstrap.Collapse.getOrCreateInstance(menu, { toggle: false }).hide();
    });
  }

  // ===== Rodapé =====
  function atualizarAno() {
    document.querySelectorAll('[data-pc-ano]').forEach(function (elemento) {
      elemento.textContent = String(new Date().getFullYear());
    });
  }

  // Cada passo isolado: um erro em um não impede os outros de rodarem
  function iniciar() {
    [configurarDownloads, montarGaleria, revelarAoRolar, fecharMenuAoNavegar, atualizarAno].forEach(function (passo) {
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
