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

  

  
}
