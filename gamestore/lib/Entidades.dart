import 'package:flutter/material.dart';
import 'dart:convert';

class User {
  String name;
  String dob;
  String email;
  String password;
  String? link;

  User({
    required this.name,
    required this.dob,
    required this.email,
    required this.password,
    this.link,
  });
}

class Jogo {
  String nome;
  double preco;
  String link;
  String descricao;

  Jogo({
    required this.nome,
    required this.preco,
    required this.link,
    required this.descricao,
  });
}
