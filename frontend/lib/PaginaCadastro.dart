import 'package:flutter/material.dart';
import 'package:validators/validators.dart';
import 'dart:convert';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
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
                            if (!RegExp(r'^[a-zA-ZÀ-ÿ ]+$').hasMatch(value)) {
                              return 'Digite apenas letras';
                            }
                            return null;
                          },
                          icon: Icons.person,
                        ),
                        const SizedBox(height: 10),
                        _buildDateField(
                          context: context,
                          controller: _dobController,
                          labelText: 'Data de Nascimento',
                          validator: (value) {
                            return value!.isEmpty ? 'Selecione uma data' : null;
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0, // Adjust to zero to make it align with the edges
            right: 0, // Adjust to zero to make it align with the edges
            child: SizedBox(
              width: double.infinity, // Take full width
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: ElevatedButton(
                  onPressed: _register,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                  ),
                  child: const Text(
                    'Registrar',
                    style: TextStyle(fontSize: 20.0, color: Colors.black),
                  ),
                ),
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

  Widget _buildDateField({
    required BuildContext context,
    required TextEditingController controller,
    required String labelText,
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
      validator: validator,
      onTap: () async {
        FocusScope.of(context).requestFocus(FocusNode());
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );
        if (pickedDate != null) {
          String formattedDate = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
          controller.text = formattedDate;
        }
      },
    );
  }

  void _register() {
    if (_formKey.currentState!.validate()) {
      final String name = _nameController.text.trim();
      final String dob = _dobController.text.trim();
      final String email = _emailController.text.trim();
      final String password = _passwordController.text.trim();

      // Criando um mapa com os dados do formulário
      final Map<String, dynamic> formData = {
        'name': name,
        'dob': dob,
        'email': email,
        'password': password,
      };

      // Convertendo o mapa em uma string JSON
      final String jsonData = jsonEncode(formData);

      // Aqui você pode fazer o que quiser com o JSON gerado
      print(jsonData);

      // Lógica adicional de registro, como enviar para um servidor, etc.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.blue,
          content: Text('Registro bem-sucedido para $name!'),
        ),
      );
    }
  }
}
