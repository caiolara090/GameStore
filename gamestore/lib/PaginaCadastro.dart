import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isButtonEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cadastro',
          style: TextStyle(fontSize: 30.0)),
        centerTitle: true,
        backgroundColor:  Colors.cyan.shade400,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.cyan.shade400, Colors.blue.shade900,],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTextField(
                controller: nameController,
                labelText: 'Nome',
                validator: (value) {
                  return value!.isEmpty || !RegExp(r'^[a-zA-Z ]+$').hasMatch(value)
                      ? 'Digite apenas letras'
                      : null;
                },
              ),
              const SizedBox(height: 10),  // Adicionado espaço entre os campos
              _buildTextField(
                controller: ageController,
                labelText: 'Idade',
                inputType: TextInputType.number,
                validator: (value) {
                  return value!.isEmpty || !RegExp(r'^[0-9]+$').hasMatch(value)
                      ? 'Digite apenas números'
                      : null;
                },
              ),
              const SizedBox(height: 10),  // Adicionado espaço entre os campos
              _buildTextField(
                controller: emailController,
                labelText: 'E-mail',
                validator: (value) {
                  return value!.isEmpty || !RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value)
                      ? 'Digite um e-mail válido'
                      : null;
                },
              ),
              const SizedBox(height: 10),  // Adicionado espaço entre os campos
              _buildTextField(
                controller: passwordController,
                labelText: 'Senha',
                isPassword: true,
                validator: (value) {
                  return value!.isEmpty ? 'Digite a senha' : null;
                },
              ),
            const SizedBox(height: 20),
            Container(
              height: 50,  // Ajuste a altura conforme necessário
              width: double.infinity,  // Ocupar a largura total disponível
              child: ElevatedButton(
                onPressed: isButtonEnabled ? _confirmRegistration : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                ),
                child: const Text(
                  'Confirmar',
                  style: TextStyle(fontSize: 20, color: Colors.black),  // Ajuste o tamanho do texto conforme necessário
                ),
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
  TextInputType? inputType,
  bool isPassword = false,
  String? Function(String?)? validator,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: inputType,
    obscureText: isPassword,
    decoration: InputDecoration(
      labelText: labelText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0), // Definindo os cantos arredondados
      ),
      errorText: validator != null ? validator(controller.text) : null,
      filled: true,
      fillColor: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.7),
    ),
    onChanged: (_) => _updateButtonState(),
  );
}


  void _updateButtonState() {
    final bool isNameValid = RegExp(r'^[a-zA-Z ]+$').hasMatch(nameController.text);
    final bool isAgeValid = RegExp(r'^[0-9]+$').hasMatch(ageController.text);
    final bool isEmailValid = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(emailController.text);
    final bool isPasswordValid = passwordController.text.isNotEmpty;

    setState(() {
      isButtonEnabled = isNameValid && isAgeValid && isEmailValid && isPasswordValid;
    });
  }

  // Medida provisória!
  void _confirmRegistration() {
    // Adicione aqui a lógica para processar o cadastro
    // Você pode acessar os valores dos campos usando as variáveis do controlador
    print('Nome: ${nameController.text}');
    print('Idade: ${ageController.text}');
    print('E-mail: ${emailController.text}');
    print('Senha: ${passwordController.text}');

    // Aqui você pode navegar para a próxima tela ou realizar outras ações necessárias
  }
}
