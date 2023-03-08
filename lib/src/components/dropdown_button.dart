import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/models.dart';

const formaPagamento = [
  'Cartão de crédito',
  'Cartão de débito',
  'Dinheiro',
  'Pix'
];

class DropdownButtonComponent extends StatefulWidget {
  const DropdownButtonComponent({super.key});

  @override
  State<DropdownButtonComponent> createState() =>
      _DropdownButtonComponentState();
}

class _DropdownButtonComponentState extends State<DropdownButtonComponent> {
  String selecionado = formaPagamento.first;
  String dropdownValue = formaPagamento.first;
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(builder: (context, child, model) {
      model.pagamento = selecionado;
      return DropdownButton<String>(
        value: selecionado,
        icon: const Icon(Icons.arrow_downward),
        elevation: 16,
        style: const TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (String? value) {
          // This is called when the user selects an item.
          setState(() {
            selecionado = value!;
            model.pagamento = selecionado;
          });
        },
        items: formaPagamento.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      );
    });
  }
}
