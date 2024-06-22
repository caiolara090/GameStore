import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'token_manager.dart';

class AddCreditsScreen extends StatefulWidget {
  const AddCreditsScreen({Key? key}) : super(key: key);

  @override
  _AddCreditsScreenState createState() => _AddCreditsScreenState();
}

class _AddCreditsScreenState extends State<AddCreditsScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _cookie;
  String? _userId;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    await _loadUserId();
    await _loadUserCookie();
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

  Future<void> addCredits(String userId, int credits) async {
    final baseUrl = '10.0.2.2:3000';
    final endPointUrl = '/addCredits';
    
    final uri = Uri.http(baseUrl, endPointUrl);

    final body = jsonEncode({
      "userId": "$_userId",
      "credits": "$credits"
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

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        print('Créditos adicionados com sucesso');
      } else {
        print('Failed to add credits: ${response.statusCode}');
      }
    } catch (e) {
      print('Error adding credits: $e');
    }
  }

  void _addCredits() async {
    if (_formKey.currentState!.validate()) {
      final String name = _nameController.text.trim();
      final String value = _valueController.text.trim();
      final String cardNumber = _cardNumberController.text.trim();
      final String expiryDate = _expiryDateController.text.trim();
      final String cvv = _cvvController.text.trim();

      if (_userId != null) {
        int credits = int.tryParse(value) ?? 0;
        await addCredits(_userId!, credits);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro: Token de usuário não encontrado.'),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, preencha todos os campos corretamente.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Colocar Créditos',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      resizeToAvoidBottomInset: true, // Evita overflow do teclado
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.cyan.shade400],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildTextField(
                    controller: _nameController,
                    labelText: 'Nome do Titular',
                    validator: (value) {
                      return value!.isEmpty ? 'Digite o nome do titular' : null;
                    },
                    icon: Icons.person,
                  ),
                  const SizedBox(height: 10),
                  _buildTextField(
                    controller: _valueController,
                    labelText: 'Valor',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Digite o valor';
                      }
                      final regex = RegExp(r'[1-9]+');
                      if (!regex.hasMatch(value)) {
                        return 'Digite um valor inteiro';
                      }
                      return null;
                    },
                    icon: Icons.attach_money,
                  ),
                  const SizedBox(height: 10),
                  _buildTextField(
                    controller: _cardNumberController,
                    labelText: 'Número do Cartão',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Digite o número do cartão';
                      }
                      String cleanedValue = value.replaceAll(' ', '');
                      if (cleanedValue.length != 16 || int.tryParse(cleanedValue) == null) {
                        return 'Número do cartão deve ter 16 dígitos';
                      }
                      return null;
                    },
                    icon: Icons.credit_card,
                  ),
                  const SizedBox(height: 10),
                  _buildTextField(
                    controller: _expiryDateController,
                    labelText: 'Data de Validade',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Digite a data de validade';
                      }
                      final regex = RegExp(r'^\d{2}/\d{2}$');
                      if (!regex.hasMatch(value)) {
                        return 'Formato da data deve ser MM/AA';
                      }
                      return null;
                    },
                    icon: Icons.date_range,
                  ),
                  const SizedBox(height: 10),
                  _buildTextField(
                    controller: _cvvController,
                    labelText: 'CVV',
                    isPassword: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Digite o CVV';
                      }
                      if (value.length != 3 || int.tryParse(value) == null) {
                        return 'CVV deve ter 3 dígitos';
                      }
                      return null;
                    },
                    icon: Icons.lock,
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: _addCredits,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 50),
                    ),
                    child: const Text(
                      'Adicionar',
                      style: TextStyle(fontSize: 20.0, color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 20.0), // Espaço opcional no final
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    bool isPassword = false,
    String? Function(String?)? validator,
    IconData? icon,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: icon != null ? Icon(icon) : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        filled: true,
        fillColor: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.7),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Colors.blue, width: 2.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Colors.red, width: 2.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Colors.red, width: 2.0),
        ),
      ),
      obscureText: isPassword,
      validator: validator,
    );
  }
}
