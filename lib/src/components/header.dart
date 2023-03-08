import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const textStyleH1 = TextStyle(fontSize: 20, fontWeight: FontWeight.w400);
    const textStyleH2 = TextStyle(fontSize: 15, fontWeight: FontWeight.w300);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: const [
            Text(
              'O que deseja comer?',
              style: textStyleH1,
            ),
            Text(
              'Temos diversas opções',
              style: textStyleH2,
            ),
          ],
        ),
        const Icon(Icons.notifications)
      ],
    );
  }
}
