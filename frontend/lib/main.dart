import 'package:flutter/material.dart';
import 'package:gamestore/PaginaBiblioteca.dart';
import 'package:gamestore/PaginaDados.dart';
import 'package:gamestore/PaginaLoja.dart';
import '/PaginaLogin.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LoginScreen(),
    routes: {
      '/dados': (context) => PaginaDados(),
      '/loja': (context) => PaginaLoja(),
      '/biblioteca':(context) => GameLibraryPage(),
    },
  ));
}