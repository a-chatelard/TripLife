import 'package:flutter/material.dart';

class PasswordTextFormField extends StatelessWidget {
  const PasswordTextFormField({
    required this.hintText,
    required this.textEditingController,
    this.valitor,
    super.key,
  });

  final String hintText;
  final TextEditingController textEditingController;
  final String? Function(String? value)? valitor;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      decoration: InputDecoration(hintText: hintText),
      obscureText: true,
      enableSuggestions: false,
      autocorrect: false,
      validator: valitor,
    );
  }
}
