import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Entidades.dart';
import 'token_manager.dart';

class FriendPage extends StatefulWidget {
  @override
  _FriendPageState createState() => _FriendPageState();
}

class _FriendPageState extends State<FriendPage> {
  List<User> users = [];

  List<User> pendingRequests = [];

  List<User> allUsers = [];

  String? _userId;
  String? _cookie;

  final ValueNotifier<List<User>> _filteredUsers = ValueNotifier<List<User>>([]);

  final TextEditingController _friendNameController = TextEditingController();
  bool _showUserList = false;

   @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    await _loadAllUsers();
    await _loadUserId();
    await _loadUserCookie();
    // print(_userId);
    // print(_cookie);
  }
    
  Future<void> _loadUserId() async {
    String? id = await CookieManager.loadId();
    setState(() {
      _userId = id;
    });
  }

  Future<void> _loadUserCookie() async {
    String? cookie = await CookieManager.loadCookie();
    setState(() {
      _cookie = cookie;
    });
  }

  

Future<void> _loadAllUsers() async {
  final baseUrl = '10.0.2.2:3000';  // Endereço base do servidor
  final endPointUrl = '/searchUser'; // Caminho específico da API
  
  final uri = Uri.http(baseUrl, endPointUrl);

  final body = jsonEncode({
    "username": "^[a-zA-ZÀ-ÿ]+"
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

  void _filterUsers(String query) {
    if (query.isEmpty) {
      _filteredUsers.value = [];
      return;
    }

    List<User> filteredUsers = allUsers.where((user) =>
        user.name.toLowerCase().contains(query.toLowerCase())).toList();
    
    _filteredUsers.value = filteredUsers;
  }

void sendFriendRequest(String friendId) async {
  final baseUrl = '10.0.2.2:3000';
  final endpointUrl = '/createFriendShipRequest';
  final uri = Uri.http(baseUrl, endpointUrl);

  final body = jsonEncode({
    "userId": _userId,
    "friendId": friendId
  });

  print('Sending POST request to: $uri');
  print('Request body: $body');

  try {
    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Cookie': 'access_token=$_cookie'
      },
      body: body,
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      print('Friend request sent successfully');
    } else {
      print('Failed to send friend request: ${response.statusCode}');
    }
  } catch (e) {
    print('Error sending friend request: $e');
  }

  _friendNameController.clear();
}


  void acceptRequest(int index) {

  }

  void rejectRequest(int index) {

  }

  void removeFriend(int index) {

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
                                sendFriendRequest(filteredUsers[index].id ?? "");
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
                      color: const Color.fromARGB(255, 254, 224, 179),
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
                  }).toList(),
                ),
          ), ],
          ),
            ),
          ),
        );
  }
}
