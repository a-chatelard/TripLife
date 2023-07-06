import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog(
      {super.key, required this.title, required this.confirmationCallback});

  final String title;
  final VoidCallback confirmationCallback;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text('Confirmer'),
          onPressed: () {
            Navigator.of(context).pop();
            confirmationCallback();
          },
        ),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text('Annuler'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
