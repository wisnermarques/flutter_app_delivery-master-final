import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/models.dart';

Future<List<Product>> listarDadosFiltrados(String text) async {
  List<Product> produtos = <Product>[];

  final Uri url = Uri.https('apidelivery-production.up.railway.app',
      '/api/produtos', {'filters[nome][\$containsi]': text, 'populate': '*'});
  var response = await http.get(url);

  if (response.statusCode == 200) {
    var listaResponse = json.decode(response.body);

    for (var produto in listaResponse['data']) {
      Product p = Product.fromJson(produto);
      produtos.add(p);
    }

    return produtos;
  } else {
    //print('Request failed with status: ${response.statusCode}.');

    return produtos;
  }
}
