import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/models.dart';

class MeusPedidos extends StatefulWidget {
  const MeusPedidos({Key? key}) : super(key: key);

  @override
  MeusPedidosState createState() => MeusPedidosState();
}

class MeusPedidosState extends State<MeusPedidos> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(
      builder: (context, child, model) {
        if (model.isLoggedIn()) {
          model.listaPedidosCliente();
        } else {
          return const Center(
              child: Text(
                  'Você precisa estar logado para visualizar seus pedidos!'));
        }
        return model.meusPedidos.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: model
                    .meusPedidos['data']['attributes']['pedidos']['data']
                    .length,
                itemBuilder: (context, index) {
                  var pedido = model.meusPedidos['data']['attributes']
                      ['pedidos']['data'][index];

                  var dataFormatada = DateFormat('dd/MM/yyyy', 'pt_BR').format(
                      DateTime.parse(pedido['attributes']['createdAt']));

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pedido #${pedido['id']}',
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              'Data do Pedido: $dataFormatada',
                              style: const TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              'Status: ${pedido['attributes']['status']}',
                              style: const TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              'Forma de Pagamento: ${pedido['attributes']['pagamento']}',
                              style: const TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            ElevatedButton(
                              onPressed: () {
                                // implementar ação para exibir detalhes do pedido
                              },
                              child: const Text('Mais Detalhes'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
      },
    );
  }
}
