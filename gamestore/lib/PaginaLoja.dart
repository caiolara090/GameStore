import 'package:flutter/material.dart';

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
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan.shade400,
        title: TextField(
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
