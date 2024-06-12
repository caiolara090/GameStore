import 'package:flutter/material.dart';
import 'PaginaBiblioteca.dart';
import 'PaginaDados.dart';
import 'PaginaLoja.dart';
import 'PaginaAmigos.dart';
import '/PaginaLogin.dart';
import 'PaginaCreditos.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LoginScreen(),
    routes: {
      '/dados': (context) => PaginaDados(),
      '/loja': (context) => PaginaLoja(),
      '/biblioteca':(context) => GameLibraryPage(),
      '/amigos':(context) => FriendPage(),
      '/creditos':(context) => AddCreditsScreen()
    },
  ));
}

