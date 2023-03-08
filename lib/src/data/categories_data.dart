import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/models.dart';

Future<List<CategoriesModel>> listarCategorias() async {
  List<CategoriesModel> categorias = <CategoriesModel>[];

  final Uri url = Uri.https('apidelivery-production.up.railway.app',
      '/api/categorias', {'populate': '*'});
  var response = await http.get(url);

  if (response.statusCode == 200) {
    var listaResponse = json.decode(response.body);

    for (var categoria in listaResponse['data']) {
      CategoriesModel p = CategoriesModel.fromJson(categoria);
      categorias.add(p);
    }

    return categorias;
  } else {
    //print('Request failed with status: ${response.statusCode}.');

    return categorias;
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
/*
final categories = [
  CategoriesModel(
      name: 'Sanduíches', img: 'lib/assets/images/01.png', total: 10),
  CategoriesModel(name: 'Açaí', img: 'lib/assets/images/02.png', total: 15),
  CategoriesModel(name: 'Açaí', img: 'lib/assets/images/03.png', total: 15),
  CategoriesModel(name: 'Açaí', img: 'lib/assets/images/04.png', total: 15),
];

*/