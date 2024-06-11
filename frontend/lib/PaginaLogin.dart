import 'package:flutter/material.dart';
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
              centerTitle: true,
              title: const Text(
                'GameStore',
                style: TextStyle(fontSize: 40.0)
                ),
              backgroundColor:  Colors.cyan.shade400
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [ Colors.cyan.shade400, Colors.indigo.shade900,],
          ),
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
                  return value!.isEmpty || !RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value)
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
                onPressed: () {
                  _login();
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 50), // Ajuste do tamanho vertical
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(fontSize: 20.0, color: Colors.black),
                ),
              ),
              const SizedBox(height: 10), // Espaçamento adicional
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RegistrationScreen()),
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
        fillColor: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.7), // Define a cor clara para o fundo
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

      // Adicione aqui a lógica de autenticação com e-mail e senha
      // Exemplo básico: verificar se o e-mail e a senha são válidos

      if (email.isNotEmpty && password.isNotEmpty) {
        // Gerar um token fictício (normalmente isso vem do servidor)
        String token = 'token1234567890';

        // Armazenar o token usando shared_preferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_token', token);

        // Lógica de autenticação bem-sucedida
        // Você pode navegar para outra tela ou executar ações necessárias aqui
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login bem-sucedido para $email!'),
          ),
        );

        // Exemplo: Navegar para outra tela após login bem-sucedido
        Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => PaginaLoja()),
      );
      } else {
        // Lógica de autenticação falhou
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Por favor, insira um e-mail e senha válidos.'),
          ),
        );
      }
    }
  }
}
