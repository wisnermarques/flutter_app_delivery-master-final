import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';

import '../components/components.dart';
import '../models/user_model.dart';

class CarrinhoPage extends StatefulWidget {
  const CarrinhoPage({super.key});

  @override
  State<CarrinhoPage> createState() => _CarrinhoPageState();
}

class _CarrinhoPageState extends State<CarrinhoPage> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(
      builder: (context, child, model) => Scaffold(
        backgroundColor: Colors.white,
        body: ListView.builder(
          itemCount: model.itensCarrinho.length,
          itemBuilder: (context, index) => CardCarrinho(
              itemCarrinho: model.itensCarrinho[index], index: index),
        ),
        bottomNavigationBar: model.itensCarrinho.length > 0
            ? _totalContainer(context, model)
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.remove_shopping_cart,
                    size: 80,
                    color: Colors.blue,
                  ),
                  Text('): Não existem dados adicionados no carrinho!'),
                ],
              ),
      ),
    );
  }
}

Widget _totalContainer(context, model) {
  double total = 0;
  double subtotal = 0;
  double taxaEntrega = 3;
  for (var item in model.itensCarrinho) {
    subtotal += double.parse(item['valor']) * item['quantidade'];
  }

  total += subtotal;

  total += taxaEntrega;

  return Container(
    height: 330.0,
    padding: const EdgeInsets.only(
      left: 10.0,
      right: 10.0,
    ),
    margin: const EdgeInsets.only(
      top: 30.0,
    ),
    child: Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Subtotal",
              style: TextStyle(
                  color: Color(0xFF9BA7C6),
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "R\$ ${NumberFormat("###.00#", "pt_BR").format(subtotal)}",
              style: const TextStyle(
                  color: Color(0xFF6C6D6D),
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(
          height: 5.0,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Taxa de Entrega",
              style: TextStyle(
                  color: Color(0xFF9BA7C6),
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "R\$ ${NumberFormat("###.00#", "pt_BR").format(taxaEntrega)}",
              style: const TextStyle(
                  color: Color(0xFF6C6D6D),
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(
          height: 5.0,
        ),
        const Divider(
          height: 2.0,
        ),
        const SizedBox(
          height: 5.0,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Total",
              style: TextStyle(
                  color: Color(0xFF9BA7C6),
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "R\$ ${NumberFormat("###.00#", "pt_BR").format(total)}",
              style: const TextStyle(
                  color: Color(0xFF6C6D6D),
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(
          height: 5.0,
        ),
        const Divider(),
        Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Endereço de entrega',
                  style: TextStyle(
                      color: Color(0xFF9BA7C6),
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Trocar'),
                )
              ],
            ),
            const Text(
                'Rua José Coelho Borges, 1100 Loteamento Ipanema, Catalão - GO - 75705-10'),
          ],
        ),
        const Divider(),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Meio de Pagamento',
              style: TextStyle(
                  color: Color(0xFF9BA7C6),
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold),
            ),
            DropdownButtonComponent()
          ],
        ),
        const Divider(),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              if (!model.isLoggedIn()) {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text("Login!!"),
                          content: const Text("Você precisa estar logado!"),
                          actions: [
                            TextButton(
                              child: const Text("Login"),
                              onPressed: () {
                                Navigator.of(context)
                                    .pushReplacementNamed('/login');
                              },
                            ),
                            TextButton(
                              child: const Text("Fechar"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ));
              } else {
                model.finalizarCompra();
                model.itensCarrinho.clear;
                model.dadosPedido.clear;
                Navigator.of(context).pushNamed('/pedido');
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            ),
            child: const Text(
              "Finalizar Pagamento",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
      ],
    ),
  );
}
