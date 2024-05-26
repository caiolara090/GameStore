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
            Text('Nome',style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),),
            Text('Saldo: ${saldo.toStringAsFixed(2)}', style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
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
                    Text(
                      'Dados da Conta:',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Nome: ',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '$nome',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Email: ',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '$email',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Idade: ',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '$idade',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Ir para a página de créditos
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 50),
                      ),
                      child: const Text(
                        'Colocar Créditos',
                        style: TextStyle(
                            fontSize: 17.0,
                            color: Color.fromARGB(255, 255, 1, 1)),
                      ),
                    ),
                    SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: () {
                        // Ir para a página de amigos
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 50),
                      ),
                      child: const Text(
                        'Amigos',
                        style: TextStyle(
                            fontSize: 17.0,
                            color: Color.fromARGB(255, 2, 122, 18)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          BottomNavigationBar(
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
        ],
      ),
    );
  }
}
