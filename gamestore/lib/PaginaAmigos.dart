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
        backgroundColor: Color.fromARGB(168, 41, 223, 255),
        title: Text(
          'Página de Amigos',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Amigos',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      title: Text(users[index].name),
                      trailing: PopupMenuButton(
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: Container(
                            width: 130, // Defina o tamanho desejado
                            child: Text(
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
                },
              ),
              SizedBox(height: 20),
              Text(
                'Pedidos',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: pendingRequests.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      title: Text(pendingRequests[index].name),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.check, color: Colors.green),
                            onPressed: () => acceptRequest(index),
                          ),
                          IconButton(
                            icon: Icon(Icons.close, color: Colors.red),
                            onPressed: () => rejectRequest(index),
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
    );
  }
}
