import 'package:flutter/material.dart';

import '../components/components.dart';
import '../components/lista_produtos.dart';
import '../data/data.dart';
import '../models/models.dart';

class TelaInicial extends StatefulWidget {
  const TelaInicial({super.key});

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
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
              itemCount: dados.length + 4,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      child: Header());
                } else if (index == 1) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    child: Categories(),
                  );
                } else if (index == 2) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Search(),
                  );
                } else if (index == 3) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Produtos Mais Vendidos",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacementNamed('/produtos');
                          },
                          child: const Text(
                            "Ver Todos",
                            style: TextStyle(
                              color: Colors.orangeAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  index -= 4;
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: ListaProdutos(produto: dados[index]),
                  );
                }
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
