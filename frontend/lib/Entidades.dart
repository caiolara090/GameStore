import 'package:flutter/material.dart';
import 'dart:convert';

class User {
  String name;
  String dob;
  String email;
  String password;
  String? link;
  String? id;

  User({
    required this.name,
    required this.dob,
    required this.email,
    required this.password,
    this.link,
    this.id
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['username'] ?? '',
      dob: json['age'].toString(),
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      id : json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'dob': dob,
      'email': email,
      'password': password,
      'link': link,
    };
  }
}

class Jogo {
  String nome;
  double preco;
  String link;
  String descricao;
  bool isFavorite;

  Jogo({
    required this.nome,
    required this.preco,
    required this.link,
    required this.descricao,
    this.isFavorite = false,
  });

  factory Jogo.fromJson(Map<String, dynamic> json) {
    return Jogo(
      nome: json['nome'],
      preco: json['preco'].toDouble(),
      link: json['link'],
      descricao: json['descricao'],
      isFavorite: json['isFavorite'] ?? false,
    );
  }
}
