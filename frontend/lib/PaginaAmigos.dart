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

  List<User> allUsers = [
    User(name: 'John Doe', dob: '01-01-1990', email: 'john.doe@example.com', password: 'password123'),
    User(name: 'Jane Smith', dob: '05-10-1985', email: 'jane.smith@example.com', password: 'password456'),
    User(name: 'Bob Johnson', dob: '12-12-1975', email: 'bob.johnson@example.com', password: 'password789'),
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

  final ValueNotifier<List<User>> _filteredUsers = ValueNotifier<List<User>>([]);

  final TextEditingController _friendNameController = TextEditingController();
  bool _showUserList = false;

  void _filterUsers(String query) {
  List<User> filtered = allUsers.where((user) {
    return user.name.toLowerCase().contains(query.toLowerCase());
  }).toList();
  _filteredUsers.value = filtered;
}

  void sendFriendRequest(String name) {
    setState(() {
      pendingRequests.add(User(name: name, dob: '', email: '', password: ''));
      _showUserList = false; // Hide the user list after sending the request
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
        backgroundColor: const Color.fromARGB(255, 0, 0, 100).withOpacity(0.9),
        title: const Text(
          'Página de Amigos',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 55,
                      child: TextField(
                        controller: _friendNameController,
                        onChanged: (text) {
                          setState(() {
                            _showUserList = text.isNotEmpty;
                          });
                          _filterUsers(text);
                        },
                        decoration: const InputDecoration(
                          labelText: 'Enviar Pedido de Amizade',
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (_showUserList)
  Container(
    height: 200,
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(10),
    ),
    child: ValueListenableBuilder<List<User>>(
      valueListenable: _filteredUsers,
      builder: (context, filteredUsers, child) {
        return ListView.builder(
          itemCount: filteredUsers.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(filteredUsers[index].name),
              trailing: ElevatedButton(
                onPressed: () {
                  sendFriendRequest(filteredUsers[index].name);
                  setState(() {
                    _showUserList = false;
                  });
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.person_add,
                      color: Colors.white,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Enviar',
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
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                ),
              ),
            );
          },
        );
      },
    ),
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
                      color: const Color.fromARGB(255, 169, 214, 254),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      child: ListTile(
                        title: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/teste.png'),
                                  fit: BoxFit.cover,
                                ),
                                shape: BoxShape.rectangle,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              user.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
                        trailing: PopupMenuButton(
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              child: Container(
                                width: 130,
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
                    'Solicitações',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  initiallyExpanded: true,
                  childrenPadding: EdgeInsets.zero,
                  children: pendingRequests.map((request) {
                    int index = pendingRequests.indexOf(request);
                    return Card(
                      color: const Color.fromARGB(255, 169, 214, 254),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      child: ListTile(
                        title: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/teste.png'),
                                  fit: BoxFit.cover,
                                ),
                                shape: BoxShape.rectangle,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              request.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
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
