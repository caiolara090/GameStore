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
    await _loadFriends();
    await _loadFriendRequests();
  }

    Future<void> _loadFriendship() async {
    await _loadFriends();
    await _loadFriendRequests();
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

Future<void> _loadFriends() async {
  final baseUrl = '10.0.2.2:3000';
  final endpointUrl = '/friends';
  final queryParameters = {
    'userId': _userId,
  };
  final uri = Uri.http(baseUrl, endpointUrl, queryParameters);

  try {
    final response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
        'Cookie': 'access_token=$_cookie'
      },
    );

    print('Response Status: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = jsonDecode(response.body);

      List<User> friends = [];

      if (data is List) {
        // Se a resposta for uma lista
        friends = data.map((friendship) {
          var friendData = friendship['friendId'];
          return User(
            name: friendData['username'] ?? '',
            dob: friendData['age'].toString(),
            email: friendData['email'] ?? '',
            password: friendData['password'] ?? '',
            id: friendData['_id'],
            credits: friendData['credits'] ?? 0,
          );
        }).toList();
      } else if (data is Map) {
        // Se a resposta for um único mapa
        var friendData = data['friendId'];
        friends.add(User(
          name: friendData['username'] ?? '',
          dob: friendData['age'].toString(),
          email: friendData['email'] ?? '',
          password: friendData['password'] ?? '',
          id: friendData['_id'],
          credits: friendData['credits'] ?? 0,
        ));
      }

      setState(() {
        users = friends; // Atualizamos a lista de usuários com os amigos
      });

      print('Friendships loaded! Users: $users');
    } else {
      print('Failed to load friendships: ${response.statusCode}');
      print('Error Body: ${response.body}');
    }
  } catch (e) {
    print('Error loading friendships: $e');
  }
}


Future<void> _loadFriendRequests() async {
  final baseUrl = '10.0.2.2:3000';
  final endpointUrl = '/friendshipRequests';

  final queryParameters = {
  'userId': '$_userId',
};
  final uri = Uri.http(baseUrl, endpointUrl, queryParameters);

    try {
    final response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
        'Cookie': 'access_token=$_cookie'
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = jsonDecode(response.body);

      List<User> friends = [];

      if (data is List) {
        // Se a resposta for uma lista
        friends = data.map((friendship) {
          var friendData = friendship['friendId'];
          return User(
            name: friendData['username'] ?? '',
            dob: friendData['age'].toString(),
            email: friendData['email'] ?? '',
            password: friendData['password'] ?? '',
            id: friendData['_id'],
            credits: friendData['credits'] ?? 0,
          );
        }).toList();
      } else if (data is Map) {
        // Se a resposta for um único mapa
        var friendData = data['friendId'];
        friends.add(User(
          name: friendData['username'] ?? '',
          dob: friendData['age'].toString(),
          email: friendData['email'] ?? '',
          password: friendData['password'] ?? '',
          id: friendData['_id'],
          credits: friendData['credits'] ?? 0,
        ));
      }

      setState(() {
        pendingRequests = friends; // Atualizamos a lista de usuários com os amigos
      });

      print('Friendships loaded! Users: $users');
    } else {
      print('Failed to load friendships: ${response.statusCode}');
      print('Error Body: ${response.body}');
    }
  } catch (e) {
    print('Error loading friendships: $e');
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

  try {
    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Cookie': 'access_token=$_cookie'
      },
      body: body,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Friend request sent successfully');
    } else {
      print('Failed to send friend request: ${response.statusCode}');
    }
  } catch (e) {
    print('Error sending friend request: $e');
  }
  _friendNameController.clear();
}


  void acceptRequest(String friendId) async{
  final baseUrl = '10.0.2.2:3000';
  final endpointUrl = '/acceptFriendshipRequest';
  final uri = Uri.http(baseUrl, endpointUrl);

  final body = jsonEncode({
    "friendId":"$friendId",
    "userId": "$_userId"
  });

  try {
    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Cookie': 'access_token=$_cookie'
      },
      body: body
    );

    if (response.statusCode == 200) {
      print('Friend request sent successfully');
      _loadFriendship();
    } else {
      print('Failed to send friend request: ${response.statusCode}');
      print(response.body);
    }
  } catch (e) {
    print('Error sending friend request: $e');
  }

  }

  void rejectRequest(String friendId) async {

  final baseUrl = '10.0.2.2:3000';
  final endpointUrl = '/rejectFriendshipRequest';
  final uri = Uri.http(baseUrl, endpointUrl);

  final body = jsonEncode({
    "friendId":"$friendId",
    "userId": "$_userId"
  });

  try {
    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Cookie': 'access_token=$_cookie'
      },
      body: body
    );

    if (response.statusCode == 200) {
      print('Pedido rejeitado');
      _loadFriendship();
    } else {
      print('Failed to reject friend request: ${response.statusCode}');
      print(response.body);
    }
  } catch (e) {
    print('Error sending friend reject: $e');
  }
  }

void removeFriend(String friendId) async {
  final baseUrl = '10.0.2.2:3000';
  final endpointUrl = '/deleteFriendship';
  final queryParameters = {
    'userId': _userId,
    'friendId': friendId,
  };

  final uri = Uri.http(baseUrl, endpointUrl, queryParameters);

  print('URI: $uri');
  print('User ID: $_userId');
  print('Friend ID: $friendId');
  print('Cookie: $_cookie');

  try {
    final response = await http.delete(
      uri,
      headers: {
        'Cookie': 'access_token=$_cookie'
      },
    );

    print('Response Status: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      print('Amizade excluída');
      _loadFriends(); // Atualiza a lista de amizades após a exclusão
    } else {
      print('Failed to delete friendship: ${response.statusCode}');
      print('Error Body: ${response.body}');
    }
  } catch (e) {
    print('Error deleting friendship: $e');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan.shade400,
        title: const Text(
          'Página de Amigos',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
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
                          onSelected: (value) => removeFriend(users[value].id!),
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
                              onPressed: () => acceptRequest(pendingRequests[index].id ?? ""),
                            ),
                            IconButton(
                              icon: Icon(Icons.close, color: Colors.red),
                              onPressed: () => rejectRequest(pendingRequests[index].id ?? ""),
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
