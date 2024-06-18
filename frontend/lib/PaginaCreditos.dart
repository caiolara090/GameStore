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
  String? _token;
  String? _id;

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  Future<void> _loadToken() async {
    String? token = await CookieManager.loadCookie();
    String? id = await CookieManager.loadId();
    setState(() {
      _token = token;
      _id = id;
    });
  }

  Future<void> addCredits(String userId, int credits) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:3000/addCredits'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'access_token' : _token ?? "",
      },
      body: jsonEncode({
        'userId': userId,
        'credits': credits,
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.blue,
          content: Text('Créditos adicionados com sucesso!', style: TextStyle(color: Colors.white)),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.blue,
          content: Text('Erro ao adicionar créditos: ${response.body}', style: TextStyle(color: Colors.white)),
        ),
      );
    }
  }

  void _addCredits() async {
    if (_formKey.currentState!.validate()) {
      final String name = _nameController.text.trim();
      final String value = _valueController.text.trim();
      final String cardNumber = _cardNumberController.text.trim();
      final String expiryDate = _expiryDateController.text.trim();
      final String cvv = _cvvController.text.trim();

      if (name.isNotEmpty && value.isNotEmpty && cardNumber.isNotEmpty && expiryDate.isNotEmpty && cvv.isNotEmpty) {
        if (_id != null) {
          int credits = int.tryParse(value) ?? 0;
          await addCredits(_id!, credits);
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
            content: Text('Por favor, preencha todos os campos.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Colocar Créditos',
          style: TextStyle(fontSize: 35.0),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.cyan.shade400],
          ),
        ),
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                    return value!.isEmpty ? 'Digite o valor' : null;
                  },
                  icon: Icons.attach_money,
                ),
                const SizedBox(height: 10),
                _buildTextField(
                  controller: _cardNumberController,
                  labelText: 'Número do Cartão',
                  validator: (value) {
                    return value!.isEmpty ? 'Digite o número do cartão' : null;
                  },
                  icon: Icons.credit_card,
                ),
                const SizedBox(height: 10),
                _buildTextField(
                  controller: _expiryDateController,
                  labelText: 'Data de Validade',
                  validator: (value) {
                    return value!.isEmpty ? 'Digite a data de validade' : null;
                  },
                  icon: Icons.date_range,
                ),
                const SizedBox(height: 10),
                _buildTextField(
                  controller: _cvvController,
                  labelText: 'CVV',
                  isPassword: true,
                  validator: (value) {
                    return value!.isEmpty ? 'Digite o CVV' : null;
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
              ],
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
