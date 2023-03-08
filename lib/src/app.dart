import 'package:flutter/material.dart';

import 'package:flutter_app_delivery/src/tabs/tabs.dart';
import 'package:scoped_model/scoped_model.dart';

import 'models/models.dart';
import 'pages/pages.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'App delivery',
        theme: ThemeData(primaryColor: Colors.blueAccent),
        initialRoute: '/',
        routes: {
          '/': (context) => const Tabs(pagina: 0, tela: TelaInicial()),
          '/login': (context) => const LoginPage(),
          '/cadastro': (context) => const CadastroPage(),
          '/produtos': (context) => const Tabs(pagina: 2, tela: ProdutosPage()),
          '/carrinho': (context) => const Tabs(pagina: 1, tela: CarrinhoPage()),
          '/pedidos': (context) => const Tabs(pagina: 3, tela: MeusPedidos()),
        },
      ),
    );
  }
}
