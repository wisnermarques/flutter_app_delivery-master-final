import 'package:flutter/material.dart';

class TopSeliingProducts extends StatelessWidget {
  const TopSeliingProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Produtos mais vendidos',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
        TextButton(
          onPressed: () {},
          child: const Text(
            'Ver todos',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.orangeAccent),
          ),
        ),
      ],
    );
  }
}
