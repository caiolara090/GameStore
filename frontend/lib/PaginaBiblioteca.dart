import 'package:flutter/material.dart';
import 'PaginaLogin.dart';
import 'PaginaLoja.dart';
import "Entidades.dart";
import 'token_manager.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GameLibraryPage extends StatefulWidget {
  @override
  _GameLibraryPageState createState() => _GameLibraryPageState();
}

class _GameLibraryPageState extends State<GameLibraryPage> {
  int _currentIndex = 1;
  List<Jogo> allGames = [];
  List<Jogo> filteredGames = [];
  TextEditingController _gameSearchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  OverlayEntry? _overlayEntry;
  String? _userId;

  @override
  void initState() {
    super.initState();
    _loadUserId();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _showOverlay();
      } else {
        _removeOverlay();
      }
    });
  }

  Future<void> _loadUserId() async {
    String? id = await CookieManager.loadId();
    setState(() {
      _userId = id;
    });
    if (_userId != null) {
      await _fetchUserGames(_userId!);
    }
  }

Future<void> _fetchUserGames(String userId) async {
  final response = await http.get(
    Uri.parse('http://10.0.2.2:3000/userGames?userId=$userId'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    List<dynamic> gamesData = jsonDecode(response.body);
    List<Jogo> loadedGames = gamesData.map((gameData) => Jogo.fromJson(gameData)).toList();
    setState(() {
      allGames = loadedGames;
      filteredGames = loadedGames;
    });
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text('Erro ao carregar jogos: ${response.body}', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

  void filterGames(String query) {
    setState(() {
      filteredGames = allGames.where((game) => game.nome.toLowerCase().contains(query.toLowerCase())).toList();
      _overlayEntry?.markNeedsBuild();
    });
  }

  void _showOverlay() {
    final overlay = Overlay.of(context);
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: 10.0,
        right: 10.0,
        top: 130.0,
        child: Material(
          elevation: 4.0,
          child: Container(
            constraints: const BoxConstraints(
              maxHeight: 200,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(0), // Borda quadrada
            ),
            child: ListView.separated(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: filteredGames.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: filteredGames[index].link.startsWith('http')
                      ? Image.network(filteredGames[index].link, width: 50, height: 50, fit: BoxFit.cover)
                      : Image.asset(filteredGames[index].link, width: 50, height: 50, fit: BoxFit.cover),
                  title: Text(filteredGames[index].nome),
                );
              },
              separatorBuilder: (context, index) => const Divider(
                color: Colors.grey,
                thickness: 1,
              ),
            ),
          ),
        ),
      ),
    );
    overlay.insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _gameSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Jogo> favoriteGames = allGames.where((game) => game.isFavorite).toList();
    List<Jogo> otherGames = allGames.where((game) => !game.isFavorite).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan.shade400,
        title: const Text(
          'Biblioteca de Jogos',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 55,
                child: TextField(
                  controller: _gameSearchController,
                  focusNode: _focusNode,
                  onChanged: filterGames,
                  decoration: const InputDecoration(
                    labelText: 'Pesquisar Jogos',
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(0)),
                    ),
                  ),
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Theme(
                data: ThemeData().copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  title: const Text(
                    'Favoritos',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  initiallyExpanded: true,
                  childrenPadding: EdgeInsets.zero,
                  children: favoriteGames.map((game) {
                    return Card(
                      color: const Color.fromARGB(255, 169, 214, 254),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      child: ListTile(
                        leading: game.link.startsWith('http')
                            ? Image.network(game.link, width: 50, height: 50, fit: BoxFit.cover)
                            : Image.asset(game.link, width: 50, height: 50, fit: BoxFit.cover),
                        title: Text(
                          game.nome,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                        trailing: IconButton(
                          icon: const Icon(Icons.star, color: Colors.yellow),
                          onPressed: () {
                            setState(() {
                              game.isFavorite = !game.isFavorite;
                            });
                          },
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 20),
              Theme(
                data: ThemeData().copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  title: const Text(
                    'Todos os Jogos',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  initiallyExpanded: true,
                  childrenPadding: EdgeInsets.zero,
                  children: otherGames.map((game) {
                    return Card(
                      color: const Color.fromARGB(255, 169, 214, 254),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      child: ListTile(
                        leading: game.link.startsWith('http')
                            ? Image.network(game.link, width: 50, height: 50, fit: BoxFit.cover)
                            : Image.asset(game.link, width: 50, height: 50, fit: BoxFit.cover),
                        title: Text(
                          game.nome,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                        trailing: IconButton(
                          icon: const Icon(Icons.star_border, color: Colors.black),
                          onPressed: () {
                            setState(() {
                              game.isFavorite = !game.isFavorite;
                            });
                          },
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(162, 38, 197, 218),
        selectedItemColor: Color.fromARGB(255, 0, 0, 0),
        currentIndex: _currentIndex,
        unselectedItemColor:
            Colors.white, 
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.videogame_asset),
            label: 'Loja',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.layers),
            label: 'Biblioteca',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_align_justify),
            label: 'Dados',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/loja');
              break;
            case 1:
              //Navegue para alguma página
              Navigator.pushReplacementNamed(context, '/biblioteca');
              break;
            case 2:
              //Navegue para alguma página
              Navigator.pushReplacementNamed(context, '/dados');
              break;
          }
        },
      ),
      );
  }
}
