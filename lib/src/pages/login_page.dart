import 'package:flutter/material.dart';
import 'package:flutter_app_delivery/src/models/user_model.dart';

import 'package:scoped_model/scoped_model.dart';

import '../components/components.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final emailController = TextEditingController();
  final senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(builder: (context, child, model) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(
                  image: AssetImage("lib/assets/images/login.gif"),
                  height: 140.0,
                  width: 140.0,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Card(
                  elevation: 5.0,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFieldComponent(
                            text: 'Email',
                            isPassword: false,
                            data: emailController,
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
                ),
                const SizedBox(
                  height: 30.0,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        model.loginUser(
                          email: emailController.text,
                          password: senhaController.text,
                          onSuccess: _onSuccess,
                          onFail: _onFail,
                        );
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
                      'Logar',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const Divider(
                  height: 35.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Não possui Cadastro?",
                      style: TextStyle(
                          color: Color(0xFFBDC2CB),
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0),
                    ),
                    const SizedBox(width: 10.0),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/cadastro');
                      },
                      child: const Text(
                        "Cadastre-se",
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Recuperar Senha?",
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.red,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  void _onSuccess() {
    Navigator.of(context).pushReplacementNamed('/carrinho');
  }

  void _onFail() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Falha ao realizar login!'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ),
    );
  }
}
