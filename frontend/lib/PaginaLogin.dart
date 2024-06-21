import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'token_manager.dart';
import '/PaginaCadastro.dart';
import 'PaginaLoja.dart';
import 'dart:convert';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';
import 'package:http/http.dart' as http;

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
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   backgroundColor: Colors.cyan.shade400,
      //   // title: const Text(
      //   //   'GameStore',
      //   //   style: TextStyle(fontSize: 40.0),
      //   // ),
      //   centerTitle: true,
      // ),
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          color: Colors.cyan.shade400,
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 120,
                    backgroundImage: AssetImage("assets/GS.jpg"),
                  ),
                ),
                  const SizedBox(height: 40.0),
                  Form(
                    key: _formKey,
                    child: Column(
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
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black,
                            ),
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

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      final String email = _emailController.text.trim();
      final String password = _passwordController.text.trim();

      if (email.isNotEmpty && password.isNotEmpty) {
        try {
          final response = await http.post(
            Uri.parse('http://10.0.2.2:3000/login'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              'email': email,
              'password': password,
            }),
          );

          if (response.statusCode == 200) {
            // Acessar cookies da resposta
            String? biscoito;
            //String? id;
            final cookies = response.headers['set-cookie'];

            Map<String, dynamic> responseBody = jsonDecode(response.body);
            String id = responseBody['info']['_id'];

            if (cookies != null) {
              final cookie = cookies.split(';').firstWhere(
                (cookie) => cookie.startsWith('access_token='),
                orElse: () => '',
              );
              biscoito = cookie.isNotEmpty ? cookie.split('=').last : null;
            }

            if (biscoito != null && biscoito.isNotEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.blue,
                  content: Text('Login bem-sucedido para $email!', style: const TextStyle(color: Colors.white)),
                ),
              );

              // Salve o cookie e o id aqui
              await CookieManager.saveCookie(biscoito);
              await CookieManager.saveId(id);

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => PaginaLoja(),
                ),
              );

            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Falha no login. ID não encontrado nos cookies.'),
                ),
              );
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Falha no login. Por favor, verifique suas credenciais.'),
              ),
            );
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Erro de rede: $e'),
            ),
          );
        }
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
