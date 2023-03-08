import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/models.dart';
import '../pages/pages.dart';

class MenuNavegacao extends StatelessWidget {
  const MenuNavegacao({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildHeader(context),
            buidMenuItems(context),
          ],
        ),
      ),
    );
  }
}

Widget buildHeader(BuildContext context) => Container(
      color: Colors.indigo,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        bottom: 24,
      ),
      child: Container(
        margin: const EdgeInsets.all(8),
        child: ScopedModelDescendant<UserModel>(
          builder: (context, child, model) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 8,
              ),
              const Center(
                child: Text(
                  'App Delivery',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              !model.isLoggedIn()
                  ? const Text(
                      'Olá, ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      'Olá, ${model.userLogado['user']['username']}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
              const SizedBox(
                height: 8,
              ),
              GestureDetector(
                onTap: () {
                  if (model.userLogado != '') {
                    model.signOut();
                    Navigator.pop(context);
                    Navigator.of(context).pushReplacementNamed('/');
                  } else {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const LoginPage()));
                  }
                },
                child: Text(
                  model.isLoggedIn() ? 'Sair' : 'Entre ou cadastre-se >',
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

Widget buidMenuItems(BuildContext context) => ScopedModelDescendant<UserModel>(
      builder: (context, child, model) => Container(
        padding: const EdgeInsets.all(24),
        child: Wrap(
          runSpacing: 4, //espaçamento vertical
          children: [
            ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Início'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).pushReplacementNamed('/');
                }),
            ListTile(
                leading: const Icon(Icons.list),
                title: const Text('Produtos'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).pushReplacementNamed('/produtos');
                }),
            ListTile(
                leading: const Icon(Icons.location_on),
                title: const Text('Lojas'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).pushReplacementNamed('/loja');
                }),
            ListTile(
              leading: const Icon(Icons.checklist),
              title: const Text('Meus pedidos'),
              onTap: () {
                if (model.isLoggedIn()) {
                  //model.(idCliente: model.idCliente);
                  Navigator.pop(context);
                  Navigator.of(context).pushReplacementNamed('/pedidos');
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Login!!'),
                      content: const Text(
                          'É preciso estar logado para visualizar seus pedidos!'),
                      actions: [
                        TextButton(
                          onPressed: () =>
                              Navigator.of(context).pushNamed('/login'),
                          child: const Text('Login'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Fechar'),
                        )
                      ],
                    ),
                  );
                }
              },
            ),
            const Divider(
              color: Colors.black54,
            ),
          ],
        ),
      ),
    );
