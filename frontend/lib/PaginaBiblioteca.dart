import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Biblioteca de Jogos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GameLibraryPage(),
    );
  }
}

class Game {
  String name;
  bool isFavorite;

  Game({required this.name, this.isFavorite = false});
}

class GameLibraryPage extends StatefulWidget {
  @override
  _GameLibraryPageState createState() => _GameLibraryPageState();
}

class _GameLibraryPageState extends State<GameLibraryPage> {
  List<Game> allGames = [
    Game(name: 'Jogo 1', isFavorite: true),
    Game(name: 'Jogo 2'),
    Game(name: 'Jogo 3', isFavorite: true),
    Game(name: 'Jogo 4'),
  ];

  TextEditingController _gameSearchController = TextEditingController();
  List<Game> filteredGames = [];

  @override
  void initState() {
    super.initState();
    filteredGames = allGames;
  }

  void filterGames(String query) {
    setState(() {
      filteredGames = allGames.where((game) => game.name.toLowerCase().contains(query.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Game> favoriteGames = filteredGames.where((game) => game.isFavorite).toList();
    List<Game> otherGames = filteredGames.where((game) => !game.isFavorite).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 0, 100).withOpacity(0.9),
        title: const Text(
          'Biblioteca de Jogos',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 55,
                child: TextField(
                  controller: _gameSearchController,
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
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
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
                        title: Text(
                          game.name,
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
                        title: Text(
                          game.name,
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
      ),
    );
  }
}
