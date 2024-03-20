import 'package:flutter/material.dart';

class PaginaDados extends StatefulWidget {
  @override
  _PaginaDadosState createState() => _PaginaDadosState();
}

class _PaginaDadosState extends State<PaginaDados> {
  int _currentIndex = 2;
  late String nome;
  late String email;
  late int idade;
  double saldo = 0.00;

  @override
  void initState() {
    super.initState();
    nome = 'Luiz Fernando Rocha';
    email = 'luiz.fernando50@gmail.com';
    idade = 25;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan.shade400,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Nome',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            Text(
              'Saldo: ${saldo.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
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
          setState(() {
            _currentIndex = index;
          });
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
