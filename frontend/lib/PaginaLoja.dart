import 'package:flutter/material.dart';
import 'token_manager.dart'; 
import 'PaginaBiblioteca.dart';
import 'Entidades.dart';
import 'PaginaDados.dart';
import 'PaginaJogo.dart';

class PaginaLoja extends StatefulWidget {
  @override
  _PaginaLojaState createState() => _PaginaLojaState();
}

class _PaginaLojaState extends State<PaginaLoja> {
  int _currentIndex = 0;
  
  // Primeira lista de jogos
  List<Jogo> jogos = [
    Jogo(
      nome: "The Witcher 3",
      descricao: "Um RPG épico aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
      preco: 59.99,
      link: "https://upload.wikimedia.org/wikipedia/pt/9/9c/Minecraft_capa.png",
      isFavorite: true,
    ),
    Jogo(
      nome: "Minecraft",
      descricao: "Construa e explore mundos infinitos, Construa e explore mundos infinitos",
      preco: 29.99,
      link: "https://upload.wikimedia.org/wikipedia/pt/9/9c/Minecraft_capa.png",
      isFavorite: true,
    ),
    Jogo(
      nome: "GTA V",
      descricao: "Um jogo de ação em mundo aberto, Um jogo de ação em mundo aberto",
      preco: 39.99,
      link: "https://upload.wikimedia.org/wikipedia/pt/9/9c/Minecraft_capa.png",
      isFavorite: true,
    ),
    Jogo(
      nome: "The Witcher 3",
      descricao: "Um RPG épico aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
      preco: 59.99,
      link: "https://upload.wikimedia.org/wikipedia/pt/9/9c/Minecraft_capa.png",
      isFavorite: true,
    ),
    Jogo(
      nome: "Minecraft",
      descricao: "Construa e explore mundos infinitos, Construa e explore mundos infinitos",
      preco: 29.99,
      link: "https://upload.wikimedia.org/wikipedia/pt/9/9c/Minecraft_capa.png",
      isFavorite: true,
    ),
    Jogo(
      nome: "GTA V",
      descricao: "Um jogo de ação em mundo aberto, Um jogo de ação em mundo aberto",
      preco: 39.99,
      link: "https://upload.wikimedia.org/wikipedia/pt/9/9c/Minecraft_capa.png",
      isFavorite: true,
    ),
    Jogo(
      nome: "The Witcher 3",
      descricao: "Um RPG épico aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
      preco: 59.99,
      link: "https://upload.wikimedia.org/wikipedia/pt/9/9c/Minecraft_capa.png",
      isFavorite: true,
    ),
    Jogo(
      nome: "Minecraft",
      descricao: "Construa e explore mundos infinitos, Construa e explore mundos infinitos",
      preco: 29.99,
      link: "https://upload.wikimedia.org/wikipedia/pt/9/9c/Minecraft_capa.png",
      isFavorite: true,
    ),
    Jogo(
      nome: "GTA V",
      descricao: "Um jogo de ação em mundo aberto, Um jogo de ação em mundo aberto",
      preco: 39.99,
      link: "https://upload.wikimedia.org/wikipedia/pt/9/9c/Minecraft_capa.png",
      isFavorite: true,
    ),
  ];

  // Segunda lista de jogos
  List<Jogo> jogos2 = [
    Jogo(
      nome: "The Witcher 3",
      descricao: "Um RPG épico aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
      preco: 59.99,
      link: "https://upload.wikimedia.org/wikipedia/pt/0/06/TW3_Wild_Hunt.png",
      isFavorite: true,
    ),
    Jogo(
      nome: "Minecraft",
      descricao: "Construa e explore mundos infinitos, Construa e explore mundos infinitos",
      preco: 29.99,
      link: "https://upload.wikimedia.org/wikipedia/pt/0/06/TW3_Wild_Hunt.png",
      isFavorite: true,
    ),
    Jogo(
      nome: "GTA V",
      descricao: "Um jogo de ação em mundo aberto, Um jogo de ação em mundo aberto",
      preco: 39.99,
      link: "https://upload.wikimedia.org/wikipedia/pt/0/06/TW3_Wild_Hunt.png",
      isFavorite: true,
    ),
  ];

  TextEditingController _searchController = TextEditingController();
  List<Jogo> _filteredJogos = [];
  List<Jogo> _filteredJogos2 = [];
  String? _token;

  @override
  void initState() {
    super.initState();
    _filteredJogos = jogos;
    _filteredJogos2 = jogos2;
    _loadToken();
  }

  Future<void> _loadToken() async {
    // Simulação do carregamento de token
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      _token = 'dummy_token'; // Token carregado
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.cyan.shade400,
        title: Center(
          child: Text(
            'GameStore',
            style: TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
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
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        onChanged: (value) {
                          setState(() {
                            _filteredJogos = jogos
                                .where((jogo) => jogo.nome
                                    .toLowerCase()
                                    .contains(value.toLowerCase()))
                                .toList();
                            _filteredJogos2 = jogos2
                                .where((jogo) => jogo.nome
                                    .toLowerCase()
                                    .contains(value.toLowerCase()))
                                .toList();
                          });
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          hintText: 'Pesquisar...',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.2, // Definindo largura relativa
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              'Nome',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          SizedBox(height: 8),
                          Center(
                            child: Text(
                              'R\$00,00',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              // Lista de jogos em alta
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Center(
                      child: Text(
                        'Jogos em Alta',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
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
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                _filteredJogos[index].nome,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              subtitle: Text(
                                _filteredJogos[index].descricao,
                                style: TextStyle(color: Colors.black),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.network(
                                    _filteredJogos[index].link, // Placeholder image URL
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'R\$${_filteredJogos[index].preco.toStringAsFixed(2)}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(), // Linha divisória entre os itens da lista
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 20), // Espaçamento entre as listas
              // Lista de todos os jogos
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Center(
                      child: Text(
                        'Todos os Jogos',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
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
                          // Implemente ação ao clicar nos jogos da segunda lista
                        },
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                _filteredJogos2[index].nome,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              subtitle: Text(
                                _filteredJogos2[index].descricao,
                                style: TextStyle(color: Colors.black),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.network(
                                    _filteredJogos2[index].link, // Placeholder image URL
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'R\$${_filteredJogos2[index].preco.toStringAsFixed(2)}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(), // Linha divisória entre os itens da lista
                          ],
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
