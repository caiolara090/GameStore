import 'package:flutter/material.dart';
import 'dart:convert';

class User {
  String name;
  String dob;
  String email;
  String password;
  String? link;
  String? id;
  int credits;

  User({
    required this.name,
    required this.dob,
    required this.email,
    required this.password,
    this.link,
    this.id,
    required this.credits,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['username'] ?? '',
      dob: json['age'].toString(),
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      id: json['_id'],
      credits: json['credits'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'dob': dob,
      'email': email,
      'password': password,
      'link': link,
      'id': id,
      'credits': credits,
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
      nome: json['name'] as String,
      preco: (json['price'] as num).toDouble(),
      link: json['image'] as String,
      descricao: json['description'] as String,
      isFavorite: json['isFavorite'] != null ? json['isFavorite'] as bool : false,
    );
  }
}
