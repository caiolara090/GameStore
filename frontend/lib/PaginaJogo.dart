import 'package:flutter/material.dart';
import 'package:gamestore/Entidades.dart';

class JogoPagina extends StatelessWidget {
  final Jogo jogo;

  JogoPagina({Key? key, required this.jogo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true, // Mostra automaticamente o botão de voltar
        flexibleSpace: Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top +
                  5.0), // Ajusta o padding superior
          child: Center(
            child: Container(
              alignment: Alignment.center,
              child: Text(
                jogo.nome,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0), // Adiciona espaço ao redor do conteúdo
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (jogo != null)
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Exibir uma imagem genérica, pois não há campo de imagem na classe Jogo
                      Image.network(
                        jogo.link, // Placeholder image URL
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 20),
                    
                    ],
                  ),
                ),
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 2.0),
                    borderRadius: BorderRadius.circular(12.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(16),
                  child: Text(
                    jogo.descricao,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 26),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Center(
                  child: Text(
                    'R\$ ${jogo.preco.toStringAsFixed(2)}',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          '${jogo.nome} adicionado à sua lista',
                          style: TextStyle(color: Colors.white), // Define a cor do texto
                        ),
                        duration: Duration(seconds: 1), // Define a duração do pop-up
                        behavior: SnackBarBehavior.fixed, // Define a animação como flutuante
                        backgroundColor: Colors.red, // Define a cor de fundo vermelho claro
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyan.shade400,
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 50,
                    ),
                  ),
                  child: const Text(
                    'Adicionar',
                    style: TextStyle(
                      fontSize: 17.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}