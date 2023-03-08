import 'package:flutter/material.dart';

import '../pages/pages.dart';

class Search extends StatelessWidget {
  Search({super.key});

  final filterController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      child: TextField(
        controller: filterController,
        style: const TextStyle(color: Colors.black, fontSize: 16),
        cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
            suffixIcon: Material(
              elevation: 2,
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultadoFiltro(
                          text: filterController.text,
                        ),
                      ));
                },
                icon: const Icon(Icons.search),
                color: Colors.black,
              ),
            ),
            border: InputBorder.none,
            hintText: 'Buscar Produtos'),
      ),
    );
  }
}
