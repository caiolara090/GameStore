import 'package:flutter/material.dart';
// import 'package:teste3/PaginaJogo.dart';

class Jogo {
  String nome;
  String descricao;
  double preco;
  bool favorito;

  Jogo(
      {required this.nome,
      required this.descricao,
      required this.preco,
      this.favorito = false});
}

class PaginaLoja extends StatefulWidget {
  @override
  _PaginaLojaState createState() => _PaginaLojaState();
}

class _PaginaLojaState extends State<PaginaLoja> {
  int _currentIndex = 0;
  List<Jogo> jogos = [
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
        backgroundColor: Colors.cyan.shade400,
        title: TextField(
          controller: _searchController,
          onChanged: (value) {
            setState(() {
              _filteredJogos = jogos
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
              Text(
                'R\$00,00',
                style: TextStyle(fontSize: 16, color: Colors.black),
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
              Center(
                child: Text(
                  'Bem-vindo à Loja',
                  style: TextStyle(
                      color: const Color.fromARGB(255, 0, 0, 0), fontSize: 20),
                ),
              ),
              SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _filteredJogos.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) =>
                      //           JogoPagina(jogo: _filteredJogos[index])),
                      // );
                    },
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(_filteredJogos[index].nome,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                          subtitle: Text(_filteredJogos[index].descricao,
                              style: TextStyle(color: Colors.black)),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset('assets/image_$index.png',
                                  height:
                                      200), 
                              SizedBox(width: 8),
                              Text(
                                  'R\$${_filteredJogos[index].preco.toStringAsFixed(2)}',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black)),
                            ],
                          ),
                        ),
                        Divider(
                            height: 1,
                            color: Colors
                                .grey), 
                      ],
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
              //Navegue para alguma página
              //Navigator.pushReplacementNamed(context, '/pagina1');
              break;
            case 1:
              //Navegue para alguma página
              //Navigator.pushReplacementNamed(context, '/pagina2');
              break;
            case 2:
              //Navegue para alguma página
              //Navigator.pushNamed(context, '/pagina3');
              break;
          }
        },
      ),
    );
  }
}
