import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/models.dart';

class AcompanhamentoPedido extends StatefulWidget {
  const AcompanhamentoPedido({super.key});

  @override
  State<AcompanhamentoPedido> createState() => _AcompanhamentoPedidoState();
}

class _AcompanhamentoPedidoState extends State<AcompanhamentoPedido> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(
      builder: (context, child, model) => Scaffold(
        body: FutureBuilder<List<Pedido>>(
          future: listarPedidos(model.idCliente),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final List<Pedido> pedidos = snapshot.data!;
              return ListView.builder(
                itemCount: pedidos.length,
                itemBuilder: (context, index) {
                  final Pedido pedido = pedidos[index];
                  final dataFormatada =
                      DateFormat('dd/MM/yyyy HH:mm:ss', 'pt_BR')
                          .format(pedido.dataPedido);
                  return Card(
                    child: ListTile(
                      title: Text(
                        'Código do Pedido: ${pedido.id}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(dataFormatada),
                      trailing: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              pedido.status,
                              textAlign: TextAlign.end,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              // ação a ser executada ao pressionar o botão
                            },
                            child: const Text('Mais detalhes'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return const Text('Erro ao carregar os pedidos');
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

listarPedidos(int idCliente) {}
