import 'package:flutter/material.dart';
import 'Entidades.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loja de Jogos Mobile',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FriendPage(),
    );
  }
}

class FriendPage extends StatefulWidget {
  @override
  _FriendPageState createState() => _FriendPageState();
}

class _FriendPageState extends State<FriendPage> {
  List<User> users = [
    User(
      name: 'Amigo 1',
      dob: '01/01/1990',
      email: 'amigo1@example.com',
      password: 'senha123',
    ),
    User(
      name: 'Amigo 2',
      dob: '02/02/1991',
      email: 'amigo2@example.com',
      password: 'senha123',
    ),
    User(
      name: 'Amigo 3',
      dob: '03/03/1992',
      email: 'amigo3@example.com',
      password: 'senha123',
    ),
  ];

  List<User> pendingRequests = [
    User(
      name: 'Bisnago',
      dob: '04/04/1993',
      email: 'bisnago@example.com',
      password: 'senha123',
    ),
    User(
      name: 'Gerônimo',
      dob: '05/05/1994',
      email: 'geronimo@example.com',
      password: 'senha123',
    ),
  ];

  final TextEditingController _friendNameController = TextEditingController();

  void sendFriendRequest(String name) {
    setState(() {
      pendingRequests.add(User(name: name, dob: '', email: '', password: ''));
    });
    _friendNameController.clear();
  }

  void acceptRequest(int index) {
    setState(() {
      users.add(pendingRequests[index]);
      pendingRequests.removeAt(index);
    });
  }

  void rejectRequest(int index) {
    setState(() {
      pendingRequests.removeAt(index);
    });
  }

  void removeFriend(int index) {
    setState(() {
      users.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 0, 100).withOpacity(0.9),
        title: const Text(
          'Página de Amigos',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.center, // Alinha os elementos verticalmente
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 55,
                      child: TextField(
                        controller: _friendNameController,
                        decoration: const InputDecoration(
                          labelText: 'Nome do Usuário',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_friendNameController.text.isNotEmpty) {
                          sendFriendRequest(_friendNameController.text);
                        }
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min, // Para ajustar o tamanho do Row ao conteúdo
                        children: [
                          Icon(
                            Icons.person_add,
                            color: Colors.white, // Define a cor do ícone como branco
                          ),
                          const SizedBox(width: 8), // Espaço entre o ícone e o texto
                          const Text(
                            'Adicionar',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Theme(
                data: ThemeData().copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  title: const Text(
                    'Amigos',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  initiallyExpanded: true,
                  childrenPadding: EdgeInsets.zero,
                  children: users.map((user) {
                    int index = users.indexOf(user);
                  return Card(
                    color: Color.fromARGB(255, 169, 214, 254), // Define a cor de fundo do card
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      title: Row(
                        children: [
                          Container(
                            width: 40, // Define a largura do quadrado da imagem
                            height: 40, // Define a altura do quadrado da imagem
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/teste.png'), // Caminho da imagem
                                fit: BoxFit.cover,
                              ),
                              shape: BoxShape.rectangle,
                            ),
                          ),
                          SizedBox(width: 10), // Espaçamento entre a imagem e o texto
                          Text(
                            user.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold, // Torna o texto em negrito
                            ),
                          ),
                        ],
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
                      trailing: PopupMenuButton(
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            child: Container(
                              width: 130, // Defina o tamanho desejado
                              child: const Text(
                                "Desfazer amizade",
                                textAlign: TextAlign.right,
                              ),
                            ),
                            value: index,
                          ),
                        ],
                        onSelected: (value) => removeFriend(value),
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
                    'Pedidos',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  initiallyExpanded: true,
                  childrenPadding: EdgeInsets.zero,
                  children: pendingRequests.map((request) {
                    int index = pendingRequests.indexOf(request);
                    return Card(
                      color: Color.fromARGB(255, 169, 214, 254), // Define a cor de fundo do card
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      child: ListTile(
                        title: Row(
                          children: [
                            Container(
                              width: 40, // Define a largura do quadrado da imagem
                              height: 40, // Define a altura do quadrado da imagem
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/teste.png'), // Caminho da imagem
                                  fit: BoxFit.cover,
                                ),
                                shape: BoxShape.rectangle,
                              ),
                            ),
                            SizedBox(width: 10), // Espaçamento entre a imagem e o texto
                            Text(
                              request.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold, // Torna o texto em negrito
                              ),
                            ),
                          ],
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.check, color: Colors.green),
                              onPressed: () => acceptRequest(index),
                            ),
                            IconButton(
                              icon: const Icon(Icons.close, color: Colors.red),
                              onPressed: () => rejectRequest(index),
                            ),
                          ],
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
