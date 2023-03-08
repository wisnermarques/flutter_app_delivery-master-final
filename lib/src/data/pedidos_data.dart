import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/models.dart';

Future<List<Pedido>> listarPedidos(idCliente) async {
  List<Pedido> pedidos = [];
  if (idCliente > 0) {
    final Uri url = Uri.https('apidelivery-production.up.railway.app',
        '/api/clientes/$idCliente', {'populate[pedidos][populate]': '*'});
    final response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonPedidos = jsonDecode(response.body);

      for (var pedido in jsonPedidos['data']['attributes']['pedidos']['data']) {
        Pedido p = Pedido.fromJson(pedido);
        pedidos.add(p);
      }
    }
    return pedidos;
  } else {
    throw Exception('Erro ao carregar pedidos');
  }
}
