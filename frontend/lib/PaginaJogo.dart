import 'package:flutter/material.dart';
import 'Entidades.dart';

class Avaliacao {
  final String nome;
  final int nota;
  final String comentario;
  final DateTime data;

  Avaliacao({
    required this.nome,
    required this.nota,
    required this.comentario,
    required this.data,
  });
}

class JogoPagina extends StatefulWidget {
  final Jogo jogo;

  JogoPagina({Key? key, required this.jogo}) : super(key: key);

  @override
  _JogoPaginaState createState() => _JogoPaginaState();
}

class _JogoPaginaState extends State<JogoPagina> {
  List<Avaliacao> avaliacoes = [
    Avaliacao(
      nome: 'João',
      nota: 4,
      comentario: 'Ótimo atendimento e ambiente agradável.',
      data: DateTime(2023, 5, 10),
    ),
    Avaliacao(
      nome: 'Maria',
      nota: 5,
      comentario: 'Excelente serviço! Recomendo a todos.',
      data: DateTime(2023, 4, 22),
    ),
    Avaliacao(
      nome: 'Pedro',
      nota: 3,
      comentario: 'Poderia melhorar no atendimento ao cliente.',
      data: DateTime(2023, 3, 15),
    ),
  ];

  // Função para calcular a média das notas das avaliações
  double calcularMediaNotas(List<Avaliacao> avaliacoes) {
    if (avaliacoes.isEmpty) return 0.0;

    double somaNotas = avaliacoes.fold(0, (previous, current) => previous + current.nota);
    return somaNotas / avaliacoes.length;
  }

  @override
  Widget build(BuildContext context) {
    // Calcular a média das notas
    double mediaNotas = calcularMediaNotas(avaliacoes);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        flexibleSpace: Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 5.0),
          child: Center(
            child: Container(
              alignment: Alignment.center,
              child: Text(
                widget.jogo.nome,
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
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (widget.jogo != null)
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.network(
                        widget.jogo.link,
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
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(16),
                  child: Text(
                    widget.jogo.descricao,
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'R\$ ${widget.jogo.preco.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '${widget.jogo.nome} adicionado à sua lista',
                              style: TextStyle(color: Colors.white),
                            ),
                            duration: Duration(seconds: 1),
                            behavior: SnackBarBehavior.fixed,
                            backgroundColor: Colors.red,
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
                        'Comprar',
                        style: TextStyle(
                          fontSize: 17.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        'Avaliações',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Média das Notas: ${mediaNotas.toStringAsFixed(1)}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10), // Espaço adicional
              // Lista de Avaliações
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: avaliacoes.length,
                itemBuilder: (context, index) {
                  final avaliacao = avaliacoes[index];
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                decoration: BoxDecoration(
                                  color: Colors.cyan.shade400,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Text(
                                  '${avaliacao.nome}',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          children: List.generate(
                            5,
                            (index) {
                              if (index < avaliacao.nota) {
                                return Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                );
                              } else {
                                return Icon(
                                  Icons.star_border,
                                  color: Colors.grey,
                                );
                              }
                            },
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          '${avaliacao.comentario}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          '${avaliacao.data.day}/${avaliacao.data.month}/${avaliacao.data.year}',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
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
