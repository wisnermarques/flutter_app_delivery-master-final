import 'package:flutter/material.dart';

class TextFieldComponent extends StatefulWidget {
  final String text;
  final bool isPassword;
  final TextEditingController data;

  const TextFieldComponent({
    required this.text,
    required this.isPassword,
    required this.data,
    super.key,
  });

  @override
  State<TextFieldComponent> createState() => _TextFieldComponentState();
}

class _TextFieldComponentState extends State<TextFieldComponent> {
  bool _toggleVisibility = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.data,
      decoration: InputDecoration(
        hintText: widget.text,
        hintStyle: const TextStyle(
          color: Color(0xFFBDC2CB),
          fontSize: 18.0,
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _toggleVisibility = !_toggleVisibility;
                  });
                },
                icon: _toggleVisibility
                    ? const Icon(Icons.visibility_off)
                    : const Icon(Icons.visibility),
              )
            : const Text(''),
      ),
      obscureText: widget.isPassword ? _toggleVisibility : false,
      validator: (text) {
        String? errorMessage;

        if (text!.isEmpty) {
          errorMessage = "O campo ${widget.text.toLowerCase()} é requerido";
        }

        if (widget.isPassword) {
          if (widget.data.text.length < 8) {
            errorMessage = 'A senha deve ter pelo menos 8 caracteres';
          }
        }

        if (widget.text == 'Email') {
          if (!widget.data.text.contains("@")) {
            errorMessage = "Seu email está incorreto";
          }
        }
        return errorMessage;
      },
    );
  }
}
