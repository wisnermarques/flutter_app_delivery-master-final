import 'package:flutter/material.dart';

import '../pages/pages.dart';

class CardCategory extends StatelessWidget {
  final String name;
  final String img;
  final int total;

  const CardCategory(
      {super.key, required this.name, required this.img, required this.total});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 20),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ResultadoFiltro(
                  text: name,
                ),
              ));
        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(children: [
              Image.network(
                'http://apidelivery-production.up.railway.app$img',
                height: 65,
                width: 65,
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '$total Produtos',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}
