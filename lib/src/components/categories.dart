import 'package:flutter/material.dart';

import '../data/data.dart';
import '../models/models.dart';
import 'components.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  late Future<List<CategoriesModel>> _categories;

  @override
  void initState() {
    super.initState();
    _categories = listarCategorias();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: FutureBuilder(
        future: _categories,
        builder: (context, snapshot) {
          var dados = snapshot.data;
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: dados!.length,
              itemBuilder: (context, index) {
                return CardCategory(
                    name: dados[index].name,
                    total: dados[index].total,
                    img: dados[index].img);
              },
              scrollDirection: Axis.horizontal,
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      /*child: _categories.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                return CardCategory(
                    name: _categories[index].name,
                    total: _categories[index].total,
                    img: _categories[index].img);
              },
              scrollDirection: Axis.horizontal,
            ),*/
    );
  }
}
