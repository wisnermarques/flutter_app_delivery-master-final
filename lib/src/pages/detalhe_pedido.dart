import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const apiBaseUrl = 'https://apidelivery-production.up.railway.app';

class DetalhePedido extends StatefulWidget {
  final int idPedido;

  const DetalhePedido({Key? key, required this.idPedido}) : super(key: key);

  @override
  DetalhePedidoState createState() => DetalhePedidoState();
}

class DetalhePedidoState extends State<DetalhePedido> {
  Future<List<Map<String, dynamic>>>? _futureProdutos;

  @override
  void initState() {
    _futureProdutos = getDadosProduto(widget.idPedido);
    super.initState();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text(
          'Pedido: #${widget.idPedido}',
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _futureProdutos,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            double total = 0;
            List<Widget> items = [];
            for (var i = 0; i < snapshot.data!.length; i++) {
              var dadosPedido = snapshot.data![i];
              String nomeDoProduto =
                  dadosPedido['produto']['data']['attributes']['nome'];
              String preco =
                  dadosPedido['produto']['data']['attributes']['valor'];
              int quantidade = dadosPedido['quantidade'];
              double subtotal = quantidade * double.parse(preco);
              total += subtotal;
              items.add(ListTile(
                title: Text(
                  nomeDoProduto,
                  style: const TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                subtitle: Row(
                  children: [
                    Text(
                      'R\$ $preco',
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    Text(
                      ' x $quantidade',
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    Text(
                      ' ===> Subtotal: R\$ ${subtotal.toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ));
            }
            return Card(
              margin: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Produtos',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Divider(),
                  Expanded(
                    child: ListView(
                      children: items,
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'R\$ ${total.toStringAsFixed(2)}',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Erro ao carregar os produtos: ${snapshot.error}'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

Future<List<Map<String, dynamic>>> getDadosProduto(int idPedido) async {
  var response = await http.get(Uri.parse(
      '$apiBaseUrl/api/pedidos/$idPedido?populate[dadosPedido][populate]=produto'));

  if (response.statusCode == 200) {
    var dadosPedido = jsonDecode(response.body)['data']['attributes']
        ['dadosPedido'] as List<dynamic>;
    return dadosPedido.cast<Map<String, dynamic>>();
  } else {
    throw Exception('erro ao exibir dados da compra');
  }
}
