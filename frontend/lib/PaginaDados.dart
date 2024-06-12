import 'package:flutter/material.dart';

class PaginaDados extends StatefulWidget {
  PaginaDados({Key? key}) : super(key: key);

  @override
  _PaginaDadosState createState() => _PaginaDadosState();
}

class _PaginaDadosState extends State<PaginaDados> {
  int _currentIndex = 2;
  late String nome;
  late String email;
  late int telefone;
  late String rua;
  late int numero;
  late String bairro;
  late String complemento;
  late String ponto_referencia;
  double saldo = 0.00;

  @override
  void initState() {
    super.initState();
    nome = 'Luiz Fernando Rocha';
    email = 'luiz.fernando50@gmail.com';
    telefone = 25;
    rua = "paranaiba";
    numero = 462;
    bairro = "Macaquinhos";
    complemento = "Perto do Posto Ipiranga";
    ponto_referencia = "Próximo ao Posto Ipiranga";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.cyan.shade400,
        title: Center(
          child: Text(
            'Informações da Conta',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.zero,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 20),
                    _buildInfoTextField('Nome:', nome),
                    _buildInfoTextField('Email:', email),
                    _buildInfoTextField('Telefone:', telefone.toString()),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/amigos');
                    // Adicionar ação para a aba "Amigos"
                  },
                  child: Text('Amigos',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black)
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/creditos');
                    // Adicionar ação para a aba "Adicionar Créditos"
                  },
                  child: Text('Adicionar Créditos',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black),
                ),
                )
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.cyan.shade400,
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

  Widget _buildInfoTextField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        enabled: false,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            fontSize: 25,
            color: Colors.cyan.shade400,
          ),
          prefixText: ' ',
        ).applyDefaults(Theme.of(context).inputDecorationTheme),
        style: TextStyle(
          fontSize: 18,
          color: Colors.black,
        ),
        controller: TextEditingController(text: value),
      ),
    );
  }
}
