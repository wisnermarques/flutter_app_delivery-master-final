import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/models.dart';

Future<List<Product>> listarDados() async {
  List<Product> produtos = <Product>[];

  final Uri url = Uri.https('apidelivery-production.up.railway.app',
      '/api/produtos', {'populate': '*'});
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

/*final produtos = [
  Product(
      id: 1,
      nome: "Sanduíche Carne",
      imagem: "lib/assets/images/01.png",
      categoria: "Sanduíches",
      valor: 50,
      desconto: 3,
      avaliacoes: 5),
  Product(
      id: 2,
      nome: "Pizza Calabresa",
      imagem: "lib/assets/images/02.png",
      categoria: "Pizza",
      valor: 40,
      desconto: 3,
      avaliacoes: 5),
];
*/