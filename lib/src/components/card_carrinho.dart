import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/models.dart';

class CardCarrinho extends StatefulWidget {
  final int index;
  final Map itemCarrinho;
  const CardCarrinho(
      {super.key, required this.itemCarrinho, required this.index});

  @override
  State<CardCarrinho> createState() => _CardCarrinhoState();
}

class _CardCarrinhoState extends State<CardCarrinho> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(
      builder: (context, child, model) => Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  border:
                      Border.all(color: const Color(0xFFD3D3D3), width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                width: 45.0,
                height: 73.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        int quantidade =
                            model.itensCarrinho[widget.index]['quantidade'];
                        setState(() {
                          if (quantidade >= 1) {
                            quantidade++;
                            model.updateCarrinho(widget.index, quantidade);
                          }
                        });
                      },
                      child: const Icon(
                        Icons.keyboard_arrow_up,
                        color: Color(0xFFD3D3D3),
                      ),
                    ),
                    Text(
                      "${model.itensCarrinho[widget.index]['quantidade']}",
                      style:
                          const TextStyle(fontSize: 18.0, color: Colors.grey),
                    ),
                    InkWell(
                      onTap: () {
                        int quantidade =
                            model.itensCarrinho[widget.index]['quantidade'];
                        setState(() {
                          if (quantidade > 1) {
                            quantidade--;

                            model.updateCarrinho(widget.index, quantidade);
                          }
                        });
                      },
                      child: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Color(0xFFD3D3D3),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Container(
                height: 70.0,
                width: 70.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          'http://apidelivery-production.up.railway.app${widget.itemCarrinho['imagem']}'),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(35.0),
                  /* boxShadow: [
                          BoxShadow(
                              //color: Colors.purple,
                              blurRadius: 5.0,
                              offset: Offset(0.0, 2.0))
                        ]*/
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              SizedBox(
                height: 73,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "${widget.itemCarrinho['nome']}",
                      style: const TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      "R\$ ${NumberFormat("###.00#", "pt_BR").format(double.parse(widget.itemCarrinho['valor']))}",
                      style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.green,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5.0),
                  ],
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {
                  model.itensCarrinho.removeAt(widget.index);

                  Navigator.of(context).pushReplacementNamed('/carrinho');
                },
                icon: const Icon(
                  Icons.cancel,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
