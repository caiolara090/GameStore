import 'package:flutter/material.dart';

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
                onPressed: () {
                  _addCredits();
                },
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

  void _addCredits() {
    if (_formKey.currentState!.validate()) {
      final String name = _nameController.text.trim();
      final String value = _valueController.text.trim();
      final String cardNumber = _cardNumberController.text.trim();
      final String expiryDate = _expiryDateController.text.trim();
      final String cvv = _cvvController.text.trim();

      // Adicione aqui a lógica para adicionar créditos
      // Exemplo básico: verificar se os campos são válidos

      if (name.isNotEmpty && value.isNotEmpty && cardNumber.isNotEmpty && expiryDate.isNotEmpty && cvv.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Créditos adicionados com sucesso para $name!'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Por favor, preencha todos os campos.'),
          ),
        );
      }
    }
  }
}
