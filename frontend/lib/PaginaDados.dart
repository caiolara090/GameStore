import 'package:flutter/material.dart';
import 'token_manager.dart';
import 'PaginaBiblioteca.dart';
import 'Entidades.dart';
import 'PaginaDados.dart';
import 'PaginaJogo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'PaginaLogin.dart';

class PaginaDados extends StatefulWidget {
  PaginaDados({Key? key}) : super(key: key);

  @override
  _PaginaDadosState createState() => _PaginaDadosState();
}

class _PaginaDadosState extends State<PaginaDados> {
  int _currentIndex = 2;
  late String nome = "";
  late String email = "";
  late String idade = "";
  late String? _userId;
  List<User> allUsers = [];
  bool isLoading = true; // Variável de estado para controlar o carregamento

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  Future<void> initializeData() async {
    await _loadUserId();
    await _loadAllUsers();
    await _getUserCreditsById(_userId!);
    setState(() {
      isLoading = false; // Define isLoading como falso após carregar os dados
    });
  }

  Future<void> _loadUserId() async {
    String? id = await CookieManager.loadId();
    setState(() {
      _userId = id;
    });
  }

  Future<void> _getUserCreditsById(String userId) async {
    for (var user in allUsers) {
      if (user.id == userId) {
        setState(() {
          nome = user.name;
          email = user.email;
          idade = user.dob;
        });
      }
    }
  }

  Future<void> _loadAllUsers() async {
    final baseUrl = '10.0.2.2:3000';
    final endPointUrl = '/searchUser';

    final uri = Uri.http(baseUrl, endPointUrl);

    final body = jsonEncode({
      "username": "^[a-zA-ZÀ-ÖØ-öø-ÿ\s]+"
    });

    try {
      final response = await http.post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Map<String, dynamic> data = jsonDecode(response.body);
        List<dynamic> usersData = data['users'];
        setState(() {
          allUsers = usersData.map((userData) => User.fromJson(userData)).toList();
        });
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      print('Error: $e');
    }
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
            fontSize: 28,
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
                  _buildInfoTextField('Idade:', idade),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                    child: Column(
                      children: [
                        ElevatedButton(
                          key: Key("Amigos"),
                          onPressed: () {
                            Navigator.pushNamed(context, '/amigos');
                            // Adicionar ação para a aba "Amigos"
                          },
                          child: Text(
                            'Amigos',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.cyan.shade600,
                            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 60),
                          ),
                        ),
                        SizedBox(height: 16), // Espaçamento entre os botões
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/creditos');
                            // Adicionar ação para a aba "Adicionar Créditos"
                          },
                          child: Text(
                            'Adicionar Créditos',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.cyan.shade600,
                            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                          ),
                        ),
                        SizedBox(height: 16), // Espaçamento entre os botões
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginScreen()), // Navegação para a tela de login
                          );
                        },
                          child: Text(
                            'Sair',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.cyan.shade600,
                            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 75),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
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

  Widget _buildInfoTextField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        enabled: false,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            fontSize: 30,
            color: Colors.cyan.shade400,
          ),
          prefixText: ' ',
        ).applyDefaults(Theme.of(context).inputDecorationTheme),
        style: TextStyle(
          fontSize: 22,
          color: Colors.black,
        ),
        controller: TextEditingController(text: value),
      ),
    );
  }
}
