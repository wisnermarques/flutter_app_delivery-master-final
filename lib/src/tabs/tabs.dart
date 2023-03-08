import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../components/components.dart';
import '../models/models.dart';
import '../pages/pages.dart';

class Tabs extends StatefulWidget {
  final int pagina;
  final Widget tela;
  const Tabs({required this.pagina, required this.tela, super.key});

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int abaAtual = 0;
  late TelaInicial telaInicial;
  late CarrinhoPage carrinho;
  late ProdutosPage produtos;
  //late CategoriasPage categorias;
  late MeusPedidos pedidos;

  late List<Widget> pages;
  late Widget pagAtual;

  @override
  void initState() {
    abaAtual = widget.pagina;
    telaInicial = const TelaInicial();
    carrinho = const CarrinhoPage();
    produtos = const ProdutosPage();
    pedidos = const MeusPedidos();

    pages = [telaInicial, carrinho, produtos, pedidos];
    pagAtual = widget.tela;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(
      builder: (context, child, model) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          elevation: 0,
          //iconTheme: const IconThemeData(color: Colors.white),
          title: Text(
            abaAtual == 0
                ? "Página Inicial"
                : abaAtual == 1
                    ? "Carrinho"
                    : abaAtual == 2
                        ? "Produtos"
                        : "Pedidos",
            style: const TextStyle(
                color: Colors.white,
                fontSize: 15.0,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                icon: const Icon(
                  Icons.notifications_none,
                  // size: 30.0,
                  color: Colors.white,
                ),
                onPressed: () {}),
            Stack(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                  tooltip: 'Carrinho de compra',
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/carrinho');
                  },
                ),
                Positioned(
                  right: 5,
                  top: 5,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 18,
                      minHeight: 18,
                    ),
                    child: Text(
                      '${model.itensCarrinho.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),

        //COLOCAR DRAWER
        drawer: const MenuNavegacao(),

        bottomNavigationBar: BottomNavigationBar(
          currentIndex: abaAtual,
          onTap: (index) {
            setState(() {
              abaAtual = index;
              pagAtual = pages[index];
            });
          },
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_cart,
              ),
              label: "Carrinho",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.photo_library,
              ),
              label: "Produtos",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.list,
              ),
              label: "Meus Pedidos",
            ),
          ],
        ),

        //TRAZER O CONTEÚDO DA PÁGINA INICIAL HOME
        body: pagAtual,
      ),
    );
  }
}
