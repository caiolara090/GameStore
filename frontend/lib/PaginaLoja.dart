import 'package:flutter/material.dart';
import 'package:gamestore/Entidades.dart';
import 'package:gamestore/PaginaDados.dart';
import 'package:gamestore/PaginaJogo.dart';
// import 'package:teste3/PaginaJogo.dart';


class PaginaLoja extends StatefulWidget {
  @override
  _PaginaLojaState createState() => _PaginaLojaState();
}

class _PaginaLojaState extends State<PaginaLoja> {
  int _currentIndex = 0;
  List<Jogo> jogos = [
    Jogo(
      nome: "The Witcher 3",
      descricao: "Um RPG épico, aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
      preco: 59.99,
      link: "https://upload.wikimedia.org/wikipedia/pt/0/06/TW3_Wild_Hunt.png"
    ),
    Jogo(
      nome: "Minecraft",
      descricao: "Construa e explore mundos infinitos",
      preco: 29.99,
      link: "https://upload.wikimedia.org/wikipedia/pt/9/9c/Minecraft_capa.png"
    ),
    Jogo(
      nome: "GTA V",
      descricao: "Um jogo de ação em mundo aberto",
      preco: 39.99,
      link: "https://upload.wikimedia.org/wikipedia/pt/8/80/Grand_Theft_Auto_V_capa.png"
    ),
    Jogo(
      nome: "The Witcher 3",
      descricao: "Um RPG épico, aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
      preco: 59.99,
      link: "https://upload.wikimedia.org/wikipedia/pt/0/06/TW3_Wild_Hunt.png"
    ),
    Jogo(
      nome: "Minecraft",
      descricao: "Construa e explore mundos infinitos",
      preco: 29.99,
      link: "https://upload.wikimedia.org/wikipedia/pt/9/9c/Minecraft_capa.png"
    ),
    Jogo(
      nome: "GTA V",
      descricao: "Um jogo de ação em mundo aberto",
      preco: 39.99,
      link: "https://upload.wikimedia.org/wikipedia/pt/8/80/Grand_Theft_Auto_V_capa.png"
    ),
    Jogo(
      nome: "The Witcher 3",
      descricao: "Um RPG épico, aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
      preco: 59.99,
      link: "https://upload.wikimedia.org/wikipedia/pt/0/06/TW3_Wild_Hunt.png"
    ),
    Jogo(
      nome: "Minecraft",
      descricao: "Construa e explore mundos infinitos",
      preco: 29.99,
      link: "https://upload.wikimedia.org/wikipedia/pt/9/9c/Minecraft_capa.png"
    ),
    Jogo(
      nome: "GTA V",
      descricao: "Um jogo de ação em mundo aberto",
      preco: 39.99,
      link: "https://upload.wikimedia.org/wikipedia/pt/8/80/Grand_Theft_Auto_V_capa.png"
    ),
    Jogo(
      nome: "The Witcher 3",
      descricao: "Um RPG épico, aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
      preco: 59.99,
      link: "https://upload.wikimedia.org/wikipedia/pt/0/06/TW3_Wild_Hunt.png"
    ),
  ];

  TextEditingController _searchController = TextEditingController();
  List<Jogo> _filteredJogos = [];

  @override
  void initState() {
    super.initState();
    _filteredJogos = jogos;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.cyan.shade400,
        title: Center(
          child: Text('GameStore',
              style: TextStyle(
                  fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold)),
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
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {
                      _filteredJogos = jogos
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            _filteredJogos[index].link,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(_filteredJogos[index].nome,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                                SizedBox(height: 5),
                                Text(_filteredJogos[index].descricao,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Colors.black)),
                                SizedBox(height: 5),
                                Text(
                                  'R\$${_filteredJogos[index].preco.toStringAsFixed(2)}',
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
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
              // Navegação para a biblioteca
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PaginaDados()),
              );
              break;
          }
        },
      ),
    );
  }
}
