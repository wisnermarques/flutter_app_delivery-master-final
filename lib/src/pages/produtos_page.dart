import 'package:flutter/material.dart';

import '../components/lista_produtos.dart';
import '../data/data.dart';
import '../models/models.dart';

class ProdutosPage extends StatefulWidget {
  const ProdutosPage({super.key});

  @override
  State<ProdutosPage> createState() => _ProdutosPageState();
}

class _ProdutosPageState extends State<ProdutosPage> {
  late Future<List<Product>> _produtos;

  @override
  void initState() {
    super.initState();

    _produtos = listarDados();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _produtos,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var dados = snapshot.data!;
          return ListView.builder(
              itemCount: dados.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: ListaProdutos(produto: dados[index]),
                );
              });
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
