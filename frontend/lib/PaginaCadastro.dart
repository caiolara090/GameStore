import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:validators/validators.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Cadastro',
          style: TextStyle(fontSize: 40.0),
        ),
        backgroundColor: Colors.cyan.shade400,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.cyan.shade400, Colors.blue.shade900],
              ),
            ),
            child: const SizedBox.expand(),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 90),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _buildTextField(
                          controller: _nameController,
                          labelText: 'Nome do Usuário',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo não pode estar vazio';
                            }
                            if (value.length > 20) {
                              return 'Nome deve ter no máximo 20 caracteres';
                            }
                            if (!RegExp(r'^[a-zA-ZÀ-ÖØ-öø-ÿ\s]+$').hasMatch(value)) {
                              return 'Digite apenas letras';
                            }
                            return null;
                          },
                          icon: Icons.person,
                        ),
                        const SizedBox(height: 10),
                        _buildAgeField(
                          controller: _ageController,
                          labelText: 'Idade',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Digite a idade';
                            }
                            if (!isNumeric(value)) {
                              return 'Idade deve ser um número';
                            }
                            return null;
                          },
                          icon: Icons.calendar_today,
                        ),
                        const SizedBox(height: 10),
                        _buildTextField(
                          controller: _emailController,
                          labelText: 'E-mail',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo não pode estar vazio';
                            }
                            if (!isEmail(value)) {
                              return 'Digite um e-mail válido';
                            }
                            return null;
                          },
                          icon: Icons.email,
                        ),
                        const SizedBox(height: 10),
                        _buildTextField(
                          controller: _passwordController,
                          labelText: 'Senha',
                          isPassword: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Digite a senha';
                            }
                            if (value.length < 6) {
                              return 'A senha deve ter pelo menos 6 caracteres';
                            }
                            return null;
                          },
                          icon: Icons.lock,
                        ),
                        const SizedBox(height: 50), // Espaço adicional
                        ElevatedButton(
                          onPressed: _register,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 50),
                          ),
                          child: const Text(
                            'Registrar',
                            style: TextStyle(fontSize: 20.0, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    bool isPassword = false,
    TextInputType? inputType,
    String? Function(String?)? validator,
    IconData? icon,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: inputType,
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

  Widget _buildAgeField({
    required TextEditingController controller,
    required String labelText,
    String? Function(String?)? validator,
    IconData? icon,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
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
      validator: validator,
    );
  }

  void _register() async {
    if (_formKey.currentState!.validate()) {
      final String name = _nameController.text.trim();
      final String age = _ageController.text.trim(); // Idade em formato de string
      final String email = _emailController.text.trim();
      final String password = _passwordController.text.trim();

      // Montando o corpo da requisição JSON
      final Map<String, dynamic> formData = {
        'email': email,
        'password': password,
        'age': age,
        'username': name, // Aqui estou usando o nome como username
      };

      // Convertendo o mapa em uma string JSON
      final String jsonData = jsonEncode(formData);

      // Enviando a requisição POST para a API
      Uri url = Uri.parse('http://10.0.2.2:3000/signup');
      try {
        final response = await http.post(
          url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonData,
        );

        // Verificando o status da resposta
        if (response.statusCode == 200 || response.statusCode == 201) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.blue,
              content: Text('Registro bem-sucedido para $name!'),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.grey,
              content: Text('Falha no registro. Tente novamente.'),
            ),
          );
          print(response.statusCode);
          print(response.body);
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.grey,
            content: Text('Erro ao conectar com o servidor.'),
          ),
        );
      }
    }
  }
}
