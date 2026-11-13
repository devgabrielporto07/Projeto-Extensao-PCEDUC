<div align="center">
  <img src="site-apresentacao-pceduc/assets/gif-readme/pose_1_acenando.gif" alt="Benchware acenando" width="280">
  <h1>PCEDUC</h1>
  <p><strong>Aprenda hardware jogando: trilhas, pontos e conquistas.</strong></p>
  <p>Projeto de extensão da <strong>UNINASSAU Campina Grande</strong> — Ciência da Computação</p>
  </p>
</div>

---

## 💡 Sobre o projeto

O **PCEDUC** é uma iniciativa de aprendizagem que torna o conhecimento sobre hardware mais acessível e divertido. No aplicativo gamificado, os conteúdos viram trilhas de lições curtas e exercícios sobre **processadores**, **placas de vídeo**, **memória RAM**, **armazenamento** e outros componentes. Conforme avançam, os usuários ganham XP, sobem de nível e desbloqueiam peças colecionáveis, com o mascote **Benchware** acompanhando a jornada.

O projeto é pensado principalmente para estudantes do ensino médio, mas também pode interessar a qualquer pessoa que queira entender melhor os computadores que usa no dia a dia.

## 🚧 Desenvolvimento

O repositório reúne a documentação, o protótipo visual, o site demonstrativo e o código do aplicativo Flutter em [`flutter/app/PCEduc`](flutter/app/PCEduc/). A versão registrada no projeto é **1.0.0+1**.

Esta primeira versão implementa a identidade visual do PCEDUC, o fluxo de boas-vindas, cadastro e login por e-mail e senha com Supabase, além das telas de trilhas, perfil, conquistas e menu. O aplicativo já pode ser executado em um dispositivo Android, mas ainda representa uma parte do produto descrito no PRD:

- A Trilha 1 apresenta o mapa inicial; outras trilhas e etapas permanecem bloqueadas.
- Alguns dados de perfil, progresso e conquistas são demonstrativos, não um histórico completo de aprendizagem.
- Recuperação de senha, lembretes diários e controles de sons ainda não estão implementados.

O [PRD](docs/modelo-de-software/prototipagem/prd/prd-pceduc.pdf) descreve também requisitos e funcionalidades planejados que não fazem parte desta versão.

## 🧰 Tecnologias

| Área | Tecnologias |
| --- | --- |
| Aplicativo mobile | Flutter e Dart |
| Autenticação e banco de dados do aplicativo | Supabase Auth e PostgreSQL |
| Site demonstrativo | HTML5, CSS3 e JavaScript |
| API REST em C# / ASP.NET Core | Prevista na documentação; não incluída no código desta versão |
| Design e prototipagem | Figma |
| Versionamento | Git e GitHub |

## 👥 Equipe

### Equipe do projeto de extensão

| Colaborador(a) | Perfil |
| --- | --- |
| Gabriel Porto | [@devgabrielporto07](https://github.com/devgabrielporto07) |
| Daniel Mota | [@dplayerf](https://github.com/dplayerf) |
| Luiz Kaynan | [@kaynan-CC](https://github.com/kaynan-CC) |
| Pedro Vinicius | [@PedroVini09](https://github.com/PedroVini09) |
| Sara Arruda | [@Sararruda](https://github.com/Sararruda) |

### Colaboradores

| Colaborador(a) | Perfil |
| --- | --- |
| Alfredo Alves | [@Alfredinkapps](https://github.com/Alfredinkapps) |
| Pedro Barbosa | [@Lightis4](https://github.com/Lightis4) |

### Orientadores

| Orientador(a) | Perfil |
| --- | --- |
| Professor Daniel | [@danielccosta9](https://github.com/danielccosta9) |
| Professora Danielly | [@daniellygualberto](https://github.com/daniellygualberto) |

## 🌐 Site demonstrativo

Acesse a [demonstração online do PCEDUC](https://devgabrielporto07.github.io/Projeto-Extensao-PCEDUC/) para conhecer o projeto. Para navegar pelas telas do aplicativo, confira o [protótipo no Figma](https://www.figma.com/proto/Nds3cFqZtrh3N2oKh1um8q/Telas-PCEDUC?node-id=10-2&t=ofcFB11myQ6Vvf07-1) ou visite o [projeto publicado na Comunidade do Figma](https://www.figma.com/community/file/1694553235804267657).

Se quiser avaliar cada tela separadamente, veja as prévias em PNG:

- [Abertura](site-apresentacao-pceduc/assets/telas/tela-01.png)
- [Trilhas](site-apresentacao-pceduc/assets/telas/tela-02.png)
- [Pergunta](site-apresentacao-pceduc/assets/telas/tela-03.png)
- [Perfil](site-apresentacao-pceduc/assets/telas/tela-04.png)

Os arquivos PNG são exportações para visualização; o projeto original e publicado está no Figma.
Para acessar todas as telas separadamente, abra a pasta [`telas-figma`](telas-figma/).

## 📄 Licença

O código e os materiais originais do projeto PCEDUC neste repositório são disponibilizados sob a [Apache License 2.0](LICENSE). Você pode usar, modificar e redistribuir esse conteúdo, inclusive para fins comerciais, desde que mantenha uma cópia da licença e os avisos de autoria e indique as alterações feitas.

A licença não concede permissão para usar marcas ou nomes do projeto como se houvesse endosso da equipe. Materiais de terceiros podem estar sujeitos a licenças próprias e não são automaticamente cobertos pela licença deste projeto.

## 💬 Contato

Tem dúvidas, sugestões ou encontrou algum problema? Abra uma [issue neste repositório](https://github.com/devgabrielporto07/Projeto-Extensao-PCEDUC/issues).
