import 'package:flutter/material.dart';
import 'token_manager.dart';
import 'PaginaBiblioteca.dart';
import 'Entidades.dart';
import 'PaginaDados.dart';
import 'PaginaJogo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PaginaLoja extends StatefulWidget {
  @override
  _PaginaLojaState createState() => _PaginaLojaState();
}

class _PaginaLojaState extends State<PaginaLoja> {
  int _currentIndex = 0;
  List<User> users = [];
  List<User> allUsers = [];
  String? _userId;
  String? _cookie;
  int? _userCredits;
  List<Jogo> allGames = [];
  List<Jogo> popularGames = [];

  TextEditingController _searchController = TextEditingController();
  List<Jogo> _filteredJogos = [];
  List<Jogo> _filteredJogos2 = [];

  @override
  void initState() {
    super.initState();
    _initializeData().then((_) {
      if (_userId != null) {
        _getUserCreditsById(_userId!).then((credits) {
          setState(() {
            _userCredits = credits;
          });
        });
      }
    });
  }

  Future<void> _initializeData() async {
    await _loadAllUsers();
    await _loadUserId();
    await _loadUserCookie();
    await _loadAllGames();
    await _loadPopularGames();
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

  Future<int?> _getUserCreditsById(String userId) async {
    for (var user in allUsers) {
      if (user.id == userId) {
        return user.credits;
      }
    }
    return null; // Retorna null se o usuário não for encontrado
  }

  Future<void> _loadAllGames() async {
    final baseUrl = '10.0.2.2:3000';
    final endPointUrl = '/searchGame';

    final uri = Uri.http(baseUrl, endPointUrl);

    final body = jsonEncode({
      "gameTitle": ".*",
      
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
        List<dynamic> gamesData = data['games'];
        setState(() {
          allGames = gamesData.map((gameData) => Jogo.fromJson(gameData)).toList();
          _filteredJogos = allGames;
        });
      } else {
        throw Exception('Failed to load games');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _loadPopularGames() async {
    final baseUrl = '10.0.2.2:3000';
    final endPointUrl = '/popular';

    final uri = Uri.http(baseUrl, endPointUrl);

    try {
      final response = await http.get(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Map<String, dynamic> data = jsonDecode(response.body);
        List<dynamic> gamesData = data['games'];
        setState(() {
          popularGames = gamesData.map((gameData) => Jogo.fromJson(gameData)).toList();
          _filteredJogos2 = popularGames;
        });
      } else {
        throw Exception('Failed to load popular games');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override

  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.cyan.shade400,
        title: const Center(
          child: Text(
            'GameStore',
            style: TextStyle(
                fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.white],
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        onChanged: (value) {
                          setState(() {
                            _filteredJogos = allGames
                                .where((jogo) => jogo.nome
                                    .toLowerCase()
                                    .contains(value.toLowerCase()))
                                .toList();
                            _filteredJogos2 = popularGames
                                .where((jogo) => jogo.nome
                                    .toLowerCase()
                                    .contains(value.toLowerCase()))
                                .toList();
                          });
                        },
                        decoration: const InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          hintText: 'Pesquisar...',
                          hintStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          labelStyle: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: Center(
                        child: Text(
                          'R\$${_userCredits ?? 0},00',
                          style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              // Lista de jogos em alta
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Center(
                      child: Text(
                        'Jogos em Alta',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _filteredJogos2.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    JogoPagina(jogo: _filteredJogos2[index])),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 4.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                _filteredJogos2[index].link,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _filteredJogos2[index].nome,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      _filteredJogos2[index].descricao,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(color: Colors.black),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      'R\$${_filteredJogos2[index].preco.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20), // Espaçamento entre as listas
              // Lista de todos os jogos
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Center(
                      child: Text(
                        'Todos os Jogos',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _filteredJogos.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    JogoPagina(jogo: _filteredJogos[index])),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 4.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                _filteredJogos[index].link,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _filteredJogos[index].nome,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      _filteredJogos[index].descricao,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(color: Colors.black),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      'R\$${_filteredJogos[index].preco.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(162, 38, 197, 218),
        selectedItemColor: const Color.fromARGB(255, 0, 0, 0),
        currentIndex: _currentIndex,
        unselectedItemColor: Colors.white,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.videogame_asset),
            label: 'Loja',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.layers),
            label: 'Biblioteca',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.format_align_justify),
            label: 'Dados',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/loja');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/biblioteca');
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/dados');
              break;
          }
        },
      ),
    );
  }
}
