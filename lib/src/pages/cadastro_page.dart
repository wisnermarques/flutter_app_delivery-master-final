import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../components/components.dart';
import '../models/models.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  // String _confirmPassword;

  final GlobalKey<FormState> _formKey = GlobalKey();
  final nomeController = TextEditingController();
  final emailController = TextEditingController();
  final senhaController = TextEditingController();
  final telefoneController = TextEditingController();
  final enderecoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(builder: (context, child, model) {
      return SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 30),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Image(
                      image: AssetImage("lib/assets/images/cadastro.png"),
                      height: 120.0,
                      width: 120.0,
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Card(
                      elevation: 5.0,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            TextFieldComponent(
                              text: 'Nome',
                              isPassword: false,
                              data: nomeController,
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            TextFieldComponent(
                              text: 'Email',
                              isPassword: false,
                              data: emailController,
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            TextFieldComponent(
                              text: 'Telefone',
                              isPassword: false,
                              data: telefoneController,
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            TextFieldComponent(
                              text: 'Endereço',
                              isPassword: false,
                              data: enderecoController,
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            TextFieldComponent(
                              text: 'Senha',
                              isPassword: true,
                              data: senhaController,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            model.createUser(
                                email: emailController.text,
                                password: senhaController.text,
                                nome: nomeController.text,
                                telefone: telefoneController.text,
                                endereco: enderecoController.text,
                                username: nomeController.text);
                            _showDialog(context);
                            //Navigator.of(context).pushReplacementNamed('/');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                        ),
                        child: const Text(
                          'Cadastrar',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const Divider(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Já possui Cadastro?",
                          style: TextStyle(
                              color: Color(0xFFBDC2CB),
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0),
                        ),
                        const SizedBox(width: 10.0),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacementNamed('/login');
                          },
                          child: const Text(
                            "Logar",
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  Future<dynamic> _showDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Cadastro!!"),
        content: const Text("Cadastro realizado com sucesso!"),
        actions: [
          TextButton(
            child: const Text("OK"),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
        ],
      ),
    );
  }
}
