import 'package:flutter/material.dart';
import 'PaginaLogin.dart';
import 'PaginaLoja.dart';
import "Entidades.dart";
import 'token_manager.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'PaginaJogo.dart';

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
  String? _cookie;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    await _loadUserId();
    await _loadUserCookie();
    if (_userId != null && _cookie != null) {
      await _fetchUserGames(_userId!);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.cyan.shade400,
          content: Text('Erro ao carregar dados do usuário', style: TextStyle(color: Colors.white)),
        ),
      );
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

Future<void> _fetchUserGames(String userId) async {
  final response = await http.get(
    Uri.parse('http://10.0.2.2:3000/userGames?userId=$userId'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Cookie': 'access_token=$_cookie'
    },
  );

  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body);

    // Mapeia a lista de jogos
    List<Jogo> loadedGames = data.map((item) => Jogo.fromApiResponse(item['game'], item['favorite'])).toList();

    // Atualiza o estado do widget
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

Future<void> setFavorite(String gameId, bool star) async {
  final baseUrl = '10.0.2.2:3000';
  final endPointUrl = '/setFavorite';
  
  final uri = Uri.http(baseUrl, endPointUrl);

  final body = jsonEncode({
    
    "userId": "$_userId",
    "gameId": "$gameId",
    
  });

  try {
    final response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Cookie': 'access_token=$_cookie'
      },
      body: body,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      await _fetchUserGames(_userId!);
      setState(() {
      });
    } else {
      throw Exception('Falha em favoritar jogo!');
    }
  } catch (e) {
    print('Error: $e');
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
            child: ListView.builder(
            itemCount: filteredGames.length,
            itemBuilder: (context, index) {
              final jogo = filteredGames[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => JogoPagina(jogo: jogo)),
                  );
                },
                child: ListTile(
                  leading: jogo.link.startsWith('http')
                      ? Image.network(jogo.link, width: 50, height: 50, fit: BoxFit.cover)
                      : Image.asset(jogo.link, width: 50, height: 50, fit: BoxFit.cover),
                  title: Text(jogo.nome),
                ),
              );
            },
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
  List<Jogo> favoriteGames = filteredGames.where((game) => game.isFavorite).toList();
  List<Jogo> otherGames = filteredGames.where((game) => !game.isFavorite).toList();

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
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => JogoPagina(jogo: game)),
                      );
                    },
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
                          setFavorite(game.id, !game.isFavorite);
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
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => JogoPagina(jogo: game)),
                      );
                    },
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
                          setFavorite(game.id, !game.isFavorite);
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
      unselectedItemColor: Colors.white,
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
