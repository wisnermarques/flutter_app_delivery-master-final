import 'package:flutter/material.dart';

import '../data/data.dart';
import '../models/models.dart';
import 'pages.dart';

class CategoriasPage extends StatefulWidget {
  const CategoriasPage({super.key});

  @override
  State<CategoriasPage> createState() => _CategoriasPageState();
}

class _CategoriasPageState extends State<CategoriasPage> {
  late Future<List<CategoriesModel>> _categories;

  @override
  void initState() {
    super.initState();
    _categories = listarCategorias();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _categories,
      builder: (context, snapshot) {
        var dados = snapshot.data;
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: dados!.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Stack(
                  children: [
                    SizedBox(
                      height: 230,
                      width: double.infinity,
                      child: Image.network(
                        'https://apidelivery-production.up.railway.app${dados[index].img}',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      left: 0.0,
                      bottom: 0.0,
                      width: 380,
                      height: 60.0,
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [Colors.black, Colors.black12]),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 10.0,
                      bottom: 10.0,
                      right: 10.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  //print(item['nome']);
                                },
                                child: Text(
                                  dados[index].name,
                                  style: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ResultadoFiltro(
                                          text: dados[index].name,
                                        ),
                                      ));
                                },
                                child: Text(
                                  "${dados[index].total} Produtos",
                                  style: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orangeAccent),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
