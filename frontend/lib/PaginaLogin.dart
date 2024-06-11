import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'token_manager.dart';
import '/PaginaCadastro.dart';
import 'PaginaLoja.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(162, 38, 197, 218),
        title: Column(
          children: [
            SizedBox(height: 20),
            const Text(
              'GameStore',
              style: TextStyle(fontSize: 40.0),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(162, 38, 197, 218),
        ),
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTextField(
                controller: _emailController,
                labelText: 'E-mail',
                validator: (value) {
                  return value!.isEmpty ||
                          !RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                              .hasMatch(value)
                      ? 'Digite um e-mail válido'
                      : null;
                },
                icon: Icons.email,
              ),
              const SizedBox(height: 10),
              _buildTextField(
                controller: _passwordController,
                labelText: 'Senha',
                isPassword: true,
                validator: (value) {
                  return value!.isEmpty ? 'Digite a senha' : null;
                },
                icon: Icons.lock,
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 50),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(fontSize: 20.0, color: Colors.black),
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegistrationScreen()),
                  );
                },
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 20),
                ),
                child: const Text(
                  'Não tem uma conta? Registre-se',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
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

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      final String email = _emailController.text.trim();
      final String password = _passwordController.text.trim();

      if (email.isNotEmpty && password.isNotEmpty) {
        String token = 'token1234567890';

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_token', token);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login bem-sucedido para $email!'),
          ),
        );

        Navigator.pushReplacementNamed(context, '/loja');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Por favor, insira um e-mail e senha válidos.'),
          ),
        );
      }
    }
  }
}
