# Telas do app (galeria do site)

Aqui ficam as telas do protótipo do PCEDUC mostradas na seção "Telas do app" do site.

As imagens atuais são PNG **transparentes de 540×1080**, já com a **moldura do iPhone** desenhada
(o site não desenha outra moldura por cima).

Para trocar ou adicionar uma tela:

1. Exporte o frame do [Figma](https://www.figma.com/proto/Nds3cFqZtrh3N2oKh1um8q/Telas-PCEDUC?node-id=10-2&t=ofcFB11myQ6Vvf07-1)
   com a moldura do celular, fundo transparente, em 540×1080 (proporção 1:2).
2. Salve aqui com nome em sequência: `tela-01.png`, `tela-02.png`, `tela-03.png`...
3. No `site/index.html`, seção `#telas`, copie um dos blocos `<figure class="pc-galeria__slide">` e ajuste:
   `src`, o `alt` (descrição curta do que a tela mostra) e o `<figcaption>` (título curto visível, ex.: "Perfil").
   O JavaScript lê os slides direto do HTML: não há lista para editar no `main.js`.

Se uma imagem não carregar, a galeria mostra o espaço reservado "Tela em breve" (RN003).
