import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/models.dart';

class ListaProdutos extends StatelessWidget {
  const ListaProdutos({
    super.key,
    required this.produto,
  });

  final Product produto;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(
      builder: (context, child, model) => ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        child: Stack(
          children: [
            SizedBox(
              height: 230,
              width: double.infinity,
              child: Image.network(
                'http://apidelivery-production.up.railway.app${produto.imagem}',
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
              //top: 160,
              left: 10.0,
              bottom: 10.0,
              right: 10.0,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          produto.nome,
                          style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: produto.avaliacoes > 0
                                  ? Theme.of(context).primaryColor
                                  : Colors.white,
                              size: 16.0,
                            ),
                            Icon(
                              Icons.star,
                              color: produto.avaliacoes > 1
                                  ? Theme.of(context).primaryColor
                                  : Colors.white,
                              size: 16.0,
                            ),
                            Icon(
                              Icons.star,
                              color: produto.avaliacoes > 2
                                  ? Theme.of(context).primaryColor
                                  : Colors.white,
                              size: 16.0,
                            ),
                            Icon(
                              Icons.star,
                              color: produto.avaliacoes > 3
                                  ? Theme.of(context).primaryColor
                                  : Colors.white,
                              size: 16.0,
                            ),
                            Icon(
                              Icons.star,
                              color: produto.avaliacoes > 4
                                  ? Theme.of(context).primaryColor
                                  : Colors.white,
                              size: 16.0,
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              "(${produto.avaliacoes} Avaliação)",
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          NumberFormat("R\$###.00#", "pt_BR")
                              .format(double.parse(produto.valor)),
                          style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        GestureDetector(
                          onTap: () {
                            model.addCarrinho(produto.id, produto.nome,
                                produto.valor, produto.imagem);

                            Navigator.of(context)
                                .pushReplacementNamed('/carrinho');
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(0),
                            child: Text(
                              "Add",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
