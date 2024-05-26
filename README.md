# Trabalho-de-Pratica-de-Software:
Trabalho referente à disciplina Prática em Desenvolvimento de Software da UFMG.

# Membros e Papéis:
- Caio Lara (Front-end)
- Lucas Almeida (Fullstack)
- Luiz Fernando Rocha (Back-end)
- Thales Augusto (Front-end)

# Escopo:

Com esse trabalho, nosso grupo pretende criar um aplicativo para celulares de uma loja de jogos digitais.
As principais funções do sistema são:

- Criar uma conta para os usuários
- Adicionar créditos à plataforma
- Comprar jogos e adicioná-los a uma bibliteca particular
- Avaliar e ver avaliações de jogos feitas por outros usuários

# Tecnologias:

- Flutter
- Dart
- Typescript
- Node.js
- Express.js
- Jest

# Backlog do Produto:

- Como usuário, quero ter uma conta, logar e deslogar dela.
- Como usuário, eu gostaria de favoritar jogos.
- Como usuário, gostaria de salvar o progresso de jogos na nuvem. *
- Como usuário, gostaria de ver quais jogos tenho em minha biblioteca
- Como usuário, gostaria de adicionar créditos ou saldo à minha conta
- Como usuário, gostaria de acessar jogos disponíveis na plataforma e comprá-los.
- Como usuário, gostaria de fazer livestreams na plataforma do jogo que comprei *
- Como usuário, gostaria de fazer avaliações textuais nos jogos que comprei.
- Como usuário, gostaria de buscar jogos pelo nome
- Como usuário, gostaria de enviar imagens dos jogos que comprei *
- Como usuário, gostaria de fazer mods para jogos *
- Como usuário, gostaria de poder completar conquistas nos jogos. *
- Como usuário, gostaria de adicionar usuários como amigos.
- Como usuário, gostaria de jogar o jogo. *
- Como usuário, gostaria de ver minhas conquistas nos jogos *

# Backlog da Sprint:

História #1: Como usuário, quero ter uma conta, logar e deslogar dela
Tarefas e responsáveis:

Criar tabelas no banco de dados. [ Luiz ]
- Implementar requisição POST para cadastro na API. [ Lucas ]
- Implementar requisição GET para login na API. [ Lucas ]
- Implementar a versão inicial da tela principal [Caio]
- Implementar as telas de login e de cadastro [Caio]
- Enviar requisição POST para a API com os dados de cadastro [Thales]
- Enviar requisição GET para a API com os dados de login [Thales]

História #2: Como usuário, gostaria de acessar jogos disponíveis na plataforma e comprá-los.
Tarefas e responsáveis:

- Implementar a tela com os jogos disponíveis [Caio e Thales]
- Implementar a tela de compra do jogo [Caio e Thales]
- Implementar no backend lógica de listar jogos disponíveis e seus preços. [ Luiz ]
- Implementar no backend lógica de subtrair créditos ao realizar uma compra. [ Luiz ]
- Implementar no backend lógica de adicionar o jogo comprado à biblioteca do usuário. [ Lucas ]

História #3: Como usuário, gostaria de ver quais jogos tenho em minha biblioteca
Tarefas e responsáveis:

- Listar os jogos na biblioteca do usuário. [ Lucas ]
- Implementar as telas de bibliotecas [Caio]

História #4: Como usuário, gostaria de adicionar créditos ou saldo à minha conta
Tarefas e responsáveis:

- Implementar a tela da carteira de créditos do usuário [Caio e Thales]
- Implementar a tela de adicionar créditos [Caio e Thales]
- Implementar a transferência de créditos para o usuário. [ Lucas] 

História #5: Como usuário, eu gostaria de favoritar jogos
Tarefas e responsáveis:

- Implementar no backend lógica de favoritar o jogo. [ Luiz ]
- Implementar a estrela de favoritos [Caio e Thales]
- Implementar a seção de favoritos na biblioteca [Caio e Thales]

História #6: Como usuário, gostaria de fazer avaliações textuais nos jogos que comprei.
Tarefas e responsáveis:

- Implementar no backend lógica de adicionar avaliação textual a um jogo. [ Luiz ]
- Implementar os campos de avaliação de texto [Caio e Thales]
- Implementar o botão de enviar avaliação [Caio e Thales]

História #7: Como usuário, gostaria de buscar jogos pelo nome
Tarefas e responsáveis:

- Implementar no backend consulta de jogos por nome. [ Lucas ]
- Implementar seção de busca na tela de jogos e na biblioteca [Caio e Thales]

História #8: Como usuário, gostaria de adicionar usuários como amigos.
Tarefas e responsáveis:

- Criar tabela de relação de amigos. [ Luiz ]
- Implementar a tela de usuários amigos [Caio e Thales]
- Implementar as solicitações [Caio e Thales]

