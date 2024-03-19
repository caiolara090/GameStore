import 'package:flutter/material.dart';
import 'package:gamestore/PaginaLoja.dart';

class PaginaBiblioteca extends StatefulWidget {
  @override
  _PaginaBibliotecaState createState() => _PaginaBibliotecaState();
}

class _PaginaBibliotecaState extends State<PaginaBiblioteca> {
  int _currentIndex = 1;
  List<Jogo> jogos2 = [
    Jogo(
        nome: "The Witcher 3",
        descricao:
            "Um RPG épico aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
        preco: 59.99),
    Jogo(
        nome: "Minecraft",
        descricao:
            "Construa e explore mundos infinitos, Construa e explore mundos infinitos",
        preco: 29.99),
    Jogo(
        nome: "GTA V",
        descricao:
            "Um jogo de ação em mundo aberto, Um jogo de ação em mundo aberto",
        preco: 39.99),
    Jogo(
        nome: "The Witcher 3",
        descricao:
            "Um RPG épico aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
        preco: 59.99),
    Jogo(
        nome: "Minecraft",
        descricao:
            "Construa e explore mundos infinitos, Construa e explore mundos infinitos",
        preco: 29.99),
    Jogo(
        nome: "GTA V",
        descricao:
            "Um jogo de ação em mundo aberto, Um jogo de ação em mundo aberto",
        preco: 39.99),
    Jogo(
        nome: "The Witcher 3",
        descricao:
            "Um RPG épico aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
        preco: 59.99),
    Jogo(
        nome: "Minecraft",
        descricao:
            "Construa e explore mundos infinitos, Construa e explore mundos infinitos",
        preco: 29.99),
    Jogo(
        nome: "GTA V",
        descricao:
            "Um jogo de ação em mundo aberto, Um jogo de ação em mundo aberto",
        preco: 39.99),
  ];

  TextEditingController _searchController = TextEditingController();
  List<Jogo> _filteredJogos2 = [];

  @override
  void initState() {
    super.initState();
    _filteredJogos2 = jogos2;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan.shade400,
        title: TextField(
          controller: _searchController,
          onChanged: (value) {
            setState(() {
              _filteredJogos2 = jogos2
                  .where((jogo) =>
                      jogo.nome.toLowerCase().contains(value.toLowerCase()))
                  .toList();
            });
          },
          decoration: InputDecoration(
            hintText: 'Pesquisar...',
            border: InputBorder.none,
          ),
        ),
        actions: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Nome',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ],
          ),
          SizedBox(width: 16),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.cyan.shade400, Colors.blue.shade900],
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20),
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 2,
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 20);
                },
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    // Seção para jogos favoritos
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            'Favoritos',
                            style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 233, 219, 24),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        ..._filteredJogos2.map((jogo) {
                          return ListTile(
                            title: Text(
                              jogo.nome,
                              style: TextStyle(fontSize: 20,
                                  fontWeight: FontWeight.bold,color: Colors.black),
                            ),
                            subtitle: Text(
                              jogo.descricao,
                              style: TextStyle(color: Colors.black),
                            ),
                            trailing: Image.asset(
                              'assets/image_${_filteredJogos2.indexOf(jogo)}.png',
                              height: 200,
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => JogoPagina(jogo: jogo),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ],
                    );
                  } else {
                    // Seção para jogos não favoritos
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            'Jogos',
                            style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 233, 219, 24),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        ..._filteredJogos2.map((jogo) {
                          return ListTile(
                            title: Text(
                              jogo.nome,
                              style: TextStyle(fontSize: 20,
                                  fontWeight: FontWeight.bold,color: Colors.black),
                            ),
                            subtitle: Text(
                              jogo.descricao,
                              style: TextStyle(color: Colors.black),
                            ),
                            trailing: Image.asset(
                              'assets/image_${_filteredJogos2.indexOf(jogo)}.png',
                              height: 200,
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => JogoPagina(jogo: jogo),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ],
                    );
                  }
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
              // Navegar para alguma página
              // Navigator.pushReplacementNamed(context, '/pagina1');
              break;
            case 1:
              // Navegar para alguma página
              // Navigator.pushReplacementNamed(context, '/pagina2');
              break;
            case 2:
              // Navegar para alguma página
              // Navigator.pushNamed(context, '/pagina3');
              break;
          }
        },
      ),
    );
  }
}
