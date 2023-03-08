import 'package:flutter/material.dart';

import '../components/lista_produtos.dart';
import '../data/data.dart';
import '../models/models.dart';

class ResultadoFiltro extends StatefulWidget {
  final String text;
  const ResultadoFiltro({super.key, required this.text});

  @override
  State<ResultadoFiltro> createState() => _ResultadoFiltroState();
}

class _ResultadoFiltroState extends State<ResultadoFiltro> {
  late Future<List<Product>> _produtos;

  @override
  void initState() {
    super.initState();

    _produtos = widget.text.isEmpty
        ? _produtos = listarDados()
        : listarDadosFiltrados(widget.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lista de Produtos',
          style: TextStyle(
              color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder(
        future: _produtos,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var dados = snapshot.data!;
            return dados.isNotEmpty
                ? ListView.builder(
                    itemCount: dados.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: ListaProdutos(produto: dados[index]),
                      );
                    })
                : const Center(
                    child: Text('): Não existe resultados para essa pesquisa!'),
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
