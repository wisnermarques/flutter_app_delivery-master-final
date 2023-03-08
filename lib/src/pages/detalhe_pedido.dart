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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pedido: #${widget.idPedido}'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _futureProdutos,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var dadosPedido = snapshot.data![index];
                String nomeDoProduto =
                    dadosPedido['produto']['data']['attributes']['nome'];
                String preco =
                    dadosPedido['produto']['data']['attributes']['valor'];
                int quantidade = dadosPedido['quantidade'];
                double subtotal = quantidade * double.parse(preco);
                return ListTile(
                  title: Text(nomeDoProduto),
                  subtitle: Row(
                    children: [
                      Text('R\$ $preco'),
                      Text('x $quantidade'),
                      Text('===> Subtotal: R\$ ${subtotal.toStringAsFixed(2)}'),
                    ],
                  ),
                );
              },
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
