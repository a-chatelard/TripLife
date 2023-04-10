import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class EmailTextFormField extends StatelessWidget {
  const EmailTextFormField(
      {super.key, required this.hintText, required this.textEditingController});

  final String hintText;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: textEditingController,
        decoration: InputDecoration(hintText: hintText),
        enableSuggestions: true,
        autocorrect: false,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Veuillez saisir une adresse mail.';
          }
          if (EmailValidator.validate(value) == false) {
            return "Veuillez saisir une adresse mail correcte.";
          }
          return null;
        });
  }
}
