import 'package:flutter/material.dart';
import '../components/components.dart';
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
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(30),
        children: [
          const Header(),
          const Categories(),
          const SizedBox(
            height: 10,
          ),
          Search(),
          const SizedBox(
            height: 20,
          ),
          const TopSeliingProducts(),
          const SizedBox(
            height: 20.0,
          ),
          FutureBuilder(
            future: _produtos,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Product> dados = snapshot.data!;
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: dados.length,
                  itemBuilder: (context, index) =>
                      const Card(child: Text('data')),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
