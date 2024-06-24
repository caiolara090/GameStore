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

# Backlog da Sprint - Ideia Inicial:

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

# Backlog da Sprint - Versão Final:

História #1: Como usuário, quero ter uma conta, logar e deslogar dela
Tarefas e responsáveis:

Criar tabelas no banco de dados. [ Luiz ]
- Implementar requisição POST para cadastro na API. [ Lucas ]
- Implementar requisição GET para login na API. [ Lucas ]
- Implementar a versão inicial da tela principal [Caio]
- Implementar as telas de login e de cadastro [Caio]
- Enviar requisição POST para a API com os dados de cadastro [Caio]
- Enviar requisição GET para a API com os dados de login [Caio]

História #2: Como usuário, gostaria de acessar jogos disponíveis na plataforma e comprá-los.
Tarefas e responsáveis:

- Implementar a tela com os jogos disponíveis [Thales]
- Implementar a tela de compra do jogo [Thales]
- Implementar no backend lógica de listar jogos disponíveis e seus preços. [ Luiz ]
- Implementar no backend lógica de subtrair créditos ao realizar uma compra. [ Luiz ]
- Implementar no backend lógica de adicionar o jogo comprado à biblioteca do usuário. [ Lucas ]

História #3: Como usuário, gostaria de ver quais jogos tenho em minha biblioteca
Tarefas e responsáveis:

- Listar os jogos na biblioteca do usuário. [ Lucas ]
- Implementar as telas de bibliotecas [Caio]

História #4: Como usuário, gostaria de adicionar créditos ou saldo à minha conta
Tarefas e responsáveis:

- Implementar a tela da carteira de créditos do usuário [Thales]
- Implementar a tela de adicionar créditos [Thales]
- Implementar a transferência de créditos para o usuário. [ Lucas] 

História #5: Como usuário, eu gostaria de favoritar jogos
Tarefas e responsáveis:

- Implementar no backend lógica de favoritar o jogo. [ Luiz ]
- Implementar a estrela de favoritos [Caio]
- Implementar a seção de favoritos na biblioteca [Caio]

História #6: Como usuário, gostaria de fazer avaliações textuais nos jogos que comprei.
Tarefas e responsáveis:

- Implementar no backend lógica de adicionar avaliação textual a um jogo. [ Luiz ]
- Implementar os campos de avaliação de texto [Thales]
- Implementar o botão de enviar avaliação [Thales]

História #7: Como usuário, gostaria de buscar jogos pelo nome
Tarefas e responsáveis:

- Implementar no backend consulta de jogos por nome. [ Lucas ]
- Implementar seção de busca na tela de jogos e na biblioteca [Caio e Thales]

História #8: Como usuário, gostaria de adicionar usuários como amigos.
Tarefas e responsáveis:

- Criar tabela de relação de amigos. [ Luiz ]
- Implementar a tela de usuários amigos [Caio]
- Implementar as solicitações [Caio]

# Documentação da arquitetura hexagonal

## Motivo da utilização

A arquitetura hexagonal foi utilizada para permitir que o domínio, que contem as entidades e as regras de negócio, ficasse livre de tecnologias, como o banco de dados e a API.

## Forma da implementação

Na implementação dessa arquitetura, foi criada uma pasta para o domínio e uma pasta para os adaptadores no back-end. 

O domínio contém uma pasta de entidades e uma pasta de portas. Nas entidades são definidas as interfaces das entidades, e nas portas são definidas as interfaces das classes de serviços (portas de entrada) e as interfaces dos repositórios (portas de saída), todas separadas em uma pasta para cada entidade. Além disso, temos uma pasta de serviços, que contém as implementações das classes de serviços.

A pasta de adaptadores, por sua vez, possui uma pasta para a API e uma para o banco de dados. Na pasta da API temos toda a implementação da lógica com o Express.js, e na pasta de banco de dados temos as definições das models do Mongoose e a implementação dos repositórios.

Dessa forma, uma chamada do front-end chega pela API, cujo controller chama métodos das classes de serviços, que, por sua vez, chamam métodos dos repositórios para acessar o banco de dados. O diagrama abaixo ilustra essa interação.

![image](https://github.com/caiolara090/GameStore/assets/108113333/866f8f1f-eaa4-4bfa-931a-bf6d1ac06109)



