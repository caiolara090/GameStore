import 'package:flutter/material.dart';
import 'token_manager.dart';
import 'Entidades.dart';
import 'PaginaDados.dart';
import 'PaginaJogo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';

class Avaliacao {
  final String nome;
  final int nota;
  final String comentario;
  final DateTime data;

  Avaliacao({
    required this.nome,
    required this.nota,
    required this.comentario,
    required this.data,
  });
}

class JogoPagina extends StatefulWidget {
  final Jogo jogo;

  JogoPagina({Key? key, required this.jogo}) : super(key: key);

  @override
  _JogoPaginaState createState() => _JogoPaginaState();
}

class _JogoPaginaState extends State<JogoPagina> {
  int _currentIndex = 2;
  late String nome = "";
  late String email = "";
  late String idade = "";
  late String? _userId;
  List<User> allUsers = [];
  bool _hasUserGame = false;
  //bool isLoading = true;
  String? _cookie;
  List<Avaliacao> avaliacoes = [
    ];
  late String? _gameId;

  final TextEditingController _avaliacaoController = TextEditingController();
  List<bool> selectedStars = [true, false, false, false, false];
  //bool isLoading = false;

  // Função para calcular a média das notas das avaliações
  double calcularMediaNotas(List<Avaliacao> avaliacoes) {
    if (avaliacoes.isEmpty) return 0.0;

    double somaNotas = avaliacoes.fold(0, (previous, current) => previous + current.nota);
    return somaNotas / avaliacoes.length;
  }
   @override
  void initState() {
    super.initState();
    initializeData();
  }

  Future<void> initializeData() async {
    await _loadUserId();
    await _loadUserCookie();
    await _loadGame();
    await _checkHasGame();
    await _loadAllUsers();
    await _getUserNameById(_userId!);
  }
  Future<void> _checkHasGame() async {
    final baseUrl = '10.0.2.2:3000';
    final endPointUrl = '/hasGame';

    final queryParameters = {
      'userId': _userId,
      'gameId': _gameId,
    };

    final uri = Uri.http(baseUrl, endPointUrl, queryParameters);

    try {
      final response = await http.get(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Cookie': 'access_token=$_cookie', // Inclui o cookie no cabeçalho da requisição
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        setState(() {
          _hasUserGame = data['hasGame'];
        });
      } else {
        throw Exception('Falha ao verificar se o usuário possui o jogo');
      }
    } catch (e) {
      print('Erro ao verificar se o usuário possui o jogo: $e');
    }
  }

  Future<void> _loadUserId() async {
    String? id = await CookieManager.loadId();
    setState(() {
      _userId = id;
    });
  }
  Future<void> _loadUserCookie() async {
    String? cookie = await CookieManager.loadCookie();
    setState(() {
      _cookie = cookie;
    });
  }
  Future<void> _loadGame() async {
  final baseUrl = '10.0.2.2:3000'; // Altere conforme o seu servidor
  final endPointUrl = '/searchGame';

  final uri = Uri.http(baseUrl, endPointUrl);

  final body = jsonEncode({
    "gameTitle": widget.jogo.nome,
    "fields": "name description price reviews" // Campos desejados
  });

  try {
    final response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      List<dynamic> games = data['games'];

      if (games.isNotEmpty) {
        Map<String, dynamic> gameData = games[0];
        List<dynamic> reviewsData = gameData['reviews'];
        _gameId = gameData['_id'];
        List<Avaliacao> loadedAvaliacoes = reviewsData.map((review) {
          return Avaliacao(
            nome: review['userId']['username'],
            nota: review['rating'],
            comentario: review['description'],
            data: DateTime.now(), // Aqui você pode usar a data real da avaliação, se disponível
          );
        }).toList();

        setState(() {
          avaliacoes = loadedAvaliacoes;
          //isLoading = false;
        });
      } else {
        throw Exception('Jogo não encontrado');
      }
    } else {
      throw Exception('Falha ao carregar as avaliações do jogo');
    }
  } catch (e) {
    print('Erro: $e');
    setState(() {
      //isLoading = false;
    });
  }
}
  Future<void> _buyGame() async {
  final baseUrl = '10.0.2.2:3000';
  final endPointUrl = '/buyGame';

  final uri = Uri.http(baseUrl, endPointUrl);

  final body = jsonEncode({
    "userId": _userId,
    "gameId": _gameId,
  });

  try {
    final response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Cookie': 'access_token=$_cookie', // Inclui o cookie no cabeçalho da requisição
      },
      body: body,
    );

    if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202 || response.statusCode == 203 || response.statusCode == 204) {
      // Operação concluída com sucesso
      print('Jogo comprado com sucesso!');
      _checkHasGame();
      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Parabéns! ${widget.jogo.nome} foi comprado!',
                              style: TextStyle(color: Colors.white),
                            ),
                            duration: Duration(seconds: 1),
                            behavior: SnackBarBehavior.fixed,
                            backgroundColor: Colors.cyan.shade400,
                          ),
                        );
      // Aqui você pode adicionar qualquer lógica adicional após a compra do jogo
    } else {
      throw Exception('Falha ao comprar o jogo');
    }
  } catch (e) {
    print('Erro ao comprar o jogo: $e');
  }
}
  Future<void> enviarAvaliacao(int nota, String comentario) async {
  final baseUrl = '10.0.2.2:3000'; // Altere conforme seu servidor
  final endPointUrl = '/review';

  final uri = Uri.http(baseUrl, endPointUrl);

  final body = jsonEncode({
    "userId": _userId,
    "gameId": _gameId,
    "rating": nota,
    "description": comentario,
  });

  try {
    final response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Cookie': 'access_token=$_cookie', // Inclui o cookie no cabeçalho da requisição
      },
      body: body,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      // Avaliação enviada com sucesso
      print('Avaliação enviada com sucesso!');
      // Aqui você pode adicionar qualquer lógica adicional após enviar a avaliação
    } else {
      throw Exception('Falha ao enviar a avaliação');
    }
  } catch (e) {
    print('Erro ao enviar a avaliação: $e');
  }
}
  Future<void> _loadAllUsers() async {
    final baseUrl = '10.0.2.2:3000';
    final endPointUrl = '/searchUser';

    final uri = Uri.http(baseUrl, endPointUrl);

    final body = jsonEncode({
      "username": "^[a-zA-ZÀ-ÖØ-öø-ÿ\s]+"
    });

    try {
      final response = await http.post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Map<String, dynamic> data = jsonDecode(response.body);
        List<dynamic> usersData = data['users'];
        setState(() {
          allUsers = usersData.map((userData) => User.fromJson(userData)).toList();
        });
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<String?> _getUserNameById(String userId) async {
    for (var user in allUsers) {
      if (user.id == userId) {
        setState(() {
          nome = user.name;
        });
      }
    }
    return null; // Retorna null se o usuário não for encontrado
  }

  @override
  Widget build(BuildContext context) {
    // Calcular a média das notas
    double mediaNotas = calcularMediaNotas(avaliacoes);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        flexibleSpace: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 5.0),
          child: Center(
            child: Container(
              alignment: Alignment.center,
              child: Text(
                widget.jogo.nome,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
  child: Padding(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.jogo != null)
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.network(
                  widget.jogo.link,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        SizedBox(height: 16),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 2.0),
              borderRadius: BorderRadius.circular(12.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            padding: EdgeInsets.all(16),
            child: Text(
              widget.jogo.descricao,
              maxLines: 15,

              // Truncar o texto em 15 linhas e adicionar a opção de ver mais

              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
        SizedBox(height: 26),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'R\$ ${widget.jogo.preco.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              ElevatedButton(
                      key: Key("Comprar"),
                      onPressed: _hasUserGame ? null : () async {
                        await _buyGame(); // Chama a função _buyGame ao clicar no botão Comprar
                        print(_gameId);
                        print(_userId);
                        
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.cyan.shade400,
                        padding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 50,
                        ),
                      ),
                      child: const Text(
                        'Comprar',
                        style: TextStyle(
                          fontSize: 17.0,
                          color: Colors.white,
                        ),
                      ),
                    ),

            ],
          ),
        ),
        SizedBox(height: 30), // Espaço antes da linha horizontal
        
        // Avaliações
        Container(
          decoration: BoxDecoration(
            color: Colors.cyan.shade400, // Fundo azul para as avaliações
            borderRadius: BorderRadius.circular(12.0),
          ),
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Título "Avaliações"
              Center(
                child: Text(
                  'Avaliações',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 8),
              // Linha decorativa
              Container(
                height: 3,
                width: 300,
                color: Colors.white,
              ),
              SizedBox(height: 8),
              // Média das Notas
              Center(
                child: Text(
                  'Média das Notas: ${mediaNotas.toStringAsFixed(1)}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 16),
              // Lista de Avaliações
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: avaliacoes.length,
                itemBuilder: (context, index) {
                  final avaliacao = avaliacoes[index];
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Nome do Avaliador
                        Text(
                          avaliacao.nome,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 8),
                        // Estrelas de Avaliação
                        Row(
                          children: List.generate(
                            5,
                            (index) => Icon(
                              index < avaliacao.nota ? Icons.star : Icons.star_border,
                              color: Colors.yellow,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        // Comentário
                        Text(
                          avaliacao.comentario,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 8),
                        // Data da Avaliação
                        Text(
                          '${avaliacao.data.day}/${avaliacao.data.month}/${avaliacao.data.year}',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: 20), // Espaço adicional
            ],
          ),
        ),
        SizedBox(height: 20),
       Container(
  height: 80,
  padding: EdgeInsets.symmetric(horizontal: 16),
  child: Center(
    child: Row(
      key: Key('textFieldKey'),
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // Ou outro alinhamento horizontal desejado
      children: [
        Expanded(
          child: TextField(
            
            controller: _avaliacaoController,
            maxLines: 1,
            //expands: true,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              hintText: 'Digite sua avaliação aqui',
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(
                  width: 3.0,
                  color: Colors.black,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ),
        ),
        SizedBox(width: 10),
        IconButton(
          onPressed: () async {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return StatefulBuilder(
                  builder: (context, setState) {
                    return AlertDialog(
                      title: Text('Avaliar'),
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(5, (index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                for (int i = 0; i <= index; i++) {
                                  selectedStars[i] = true;
                                }
                                for (int i = index + 1; i < 5; i++) {
                                  selectedStars[i] = false;
                                }
                              });
                            },
                            child: Icon(
                              selectedStars[index] ? Icons.star : Icons.star_border,
                              color: selectedStars[index] ? Colors.yellow : null,
                            ),
                          );
                        }),
                      ),
                      actions: <Widget>[
                        ElevatedButton(
                          key: Key('enviarava'),
                          onPressed: () async {
                            String avaliacaoTexto = _avaliacaoController.text;
                            int notaAvaliacao = selectedStars.where((star) => star).length;

                            // Chamada para enviar avaliação
                            await enviarAvaliacao(notaAvaliacao, avaliacaoTexto);

                            // Adicionar nova avaliação localmente (opcional)
                            Avaliacao novaAvaliacao = Avaliacao(
                              nome: nome,
                              nota: notaAvaliacao,
                              comentario: avaliacaoTexto,
                              data: DateTime.now(),
                            );

                            setState(() {
                              avaliacoes.add(novaAvaliacao);
                              mediaNotas = calcularMediaNotas(avaliacoes);
                            });

                            _avaliacaoController.clear();
                            Navigator.of(context).pop();

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Avaliação inserida com sucesso!'),
                                duration: Duration(seconds: 1),
                                behavior: SnackBarBehavior.fixed,
                                backgroundColor: Colors.cyan.shade400,
                              ),
                            );
                            await _loadGame();
                          },
                          child: Text('Enviar'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.cyan.shade400,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            );
          },
          icon: Icon(Icons.send),
          color: Colors.cyan.shade400,
        ),
      ],
    ),
  ),
),
      ],
    ),
  ),
),
    );
  }
}

                  
